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
    process({ email: 'foo@bar.  com', timestamp: Time.now.to_i, event: 'delivered' })
    assert_equal 1, @events.size
    assert_equal 'delivered', @events.first.name
  end


  test "throws error for nil event processor" do
    Gridhook.config.event_processor = nil

    error = assert_raises(Gridhook::InvalidEventProcessor) do
      process({ email: 'foo@bar.  com', timestamp: Time.now.to_i, event: 'delivered' })
    end

    assert_equal "Your event processor is nil or does not response to a `call' method.", error.message
  end

  test 'parsing incoming (valid) JSON in batches' do
    skip('for when sendgrid fix their JSON batch requests')
    process([
      { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'delivered' },
      { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'open' }
    ])
    assert_equal 2, @events.size
  end

  private

  def process(params)
    Gridhook::Event.process(params)
  end

end