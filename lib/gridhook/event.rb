module Gridhook
  class Event

    def self.process(body)
      parser = Yajl::Parser.new
      parser.on_parse_complete = proc do |event|
        if event.is_a?(Array)
          process_events event
        else
          process_event event
        end
      end
      parser.parse(body)
    end

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.with_indifferent_access
    end

    def name
      attributes[:event]
    end

    def timestamp
      Time.at (attributes[:timestamp] || Time.now).to_i
    end

    def [](key)
      attributes[key]
    end

    class << self
      private

      def process_events(events)
        events.each { |e| process_event e }
      end

      def process_event(event)
        processor = Gridhook.config.event_processor
        if processor.respond_to?(:call)
          processor.call Event.new(event)
        else
          raise InvalidEventProcessor, "Your event processor is nil or "\
            "does not response to a `call' method."
        end
      end
    end

  end
end