# Gridhook

A Rails engine providing an endpoint for handling incoming SendGrid
webhook events.

## Installation

Add Gridhook to your application's Gemfile and run `bundle install`:

```ruby
gem 'gridhook'
```

Add a route for the default event handling endpoint that Gridhook provides:

```ruby
post '/email_event' => 'gridhook/events#create'
```

You must also tell Gridhook how to process your event. Simply add an
initializer in `config/initializers/gridhook.rb`:

```ruby
Gridhook.configure do |config|
  config.event_processor = proc do |event|
    # event is a Gridhook::Event object
    EmailEvent.create! event.attributes
  end
end
```

The `config.event_processor` just needs to be any object that responds to
`call()`. So, if you'd prefer to use a separate class, that's fine:

```ruby
class EventProcessor
  def call(event)
    # do some stuff with my event!
  end
end

# config/initializers/gridhook.rb
Gridhook.configure do |config|
  config.event_processor = EventProcessor.new
end
```

## More Information

* [SendGrid Webhooks](http://sendgrid.com/docs/API_Reference/Webhooks/index.html)
* [SendGrid Webhooks/Event](http://sendgrid.com/docs/API_Reference/Webhooks/event.html)