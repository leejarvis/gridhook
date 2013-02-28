require 'helper'

# http://sendgrid.com/docs/API_Reference/Webhooks/event.html

class EventTest < TestCase

  def setup
    @events = []
    Gridhook.config.event_processor = proc do |event|
      @events << event
    end
  end

  test 'parsing a single incoming JSON object' do
    obj = { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'delivered' }
    process obj.to_json
    assert_equal 1, @events.size
    assert_equal 'delivered', @events.first.name
  end

  test 'parsing incoming (invalid) JSON in batches' do
    process <<-E
      {"email":"foo@bar.com","timestamp":1322000095,"unique_arg":"my unique arg","event":"delivered"}
      {"email":"foo@bar.com","timestamp":1322000096,"unique_arg":"my unique arg","event":"open"}
    E
    assert_kind_of Gridhook::Event, @events.first
    assert_equal 2, @events.size
  end

  # for when sendgrid fix their JSON batch requests
  test 'parsing incoming (valid) JSON in batches' do
    obj = [
      { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'delivered' },
      { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'open' }
    ]
    process obj.to_json
    assert_equal 2, @events.size
  end

  private

  def process(str)
    Gridhook::Event.process(str)
  end

end