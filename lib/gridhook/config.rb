module Gridhook

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield config
  end

  class Config < Struct.new(:event_processor, :event_receive_path)
    def initialize(*)
      super
    end
  end

end