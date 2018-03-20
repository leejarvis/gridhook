[![Build Status](https://travis-ci.org/leejarvis/gridhook.svg?branch=master)](https://travis-ci.org/leejarvis/gridhook)

# Gridhook

Gridhook is a Rails engine providing an endpoint for handling incoming
SendGrid webhook events.

This engine supports both batched and non-batched events from SendGrid.

Looking to handle incoming email from the SendGrid Parse API? Gridhook
will eventually support that, until then, you should check out
[Griddler](https://github.com/thoughtbot/griddler). It's awesome.

[![Build Status](https://travis-ci.org/leejarvis/gridhook.svg?branch=master)](http://travis-ci.org/leejarvis/gridhook)

## Installation

Add Gridhook to your application's Gemfile and run `bundle install`:

```ruby
gem 'gridhook'
```

You must also tell Gridhook how to process your event. Simply add an
initializer in `config/initializers/gridhook.rb`:

```ruby
Gridhook.configure do |config|
  # The path we want to receive events
  config.event_receive_path = '/sendgrid/event'

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

## Changelog
v0.2.3 Removed 'multi_json' dependency

v0.2.2 Require decorators as dependency

v0.2.1 Use built-in rails JSON parser.

v0.2.0 Supports version 3 of the Sendgrid webhook released on
September 6th, 2013, which provides the proper headers and JSON post body
without hacks or middleware. If upgrading to this version, please make sure
to update the Webhooks settings in your SendGrid App to use V3 of their API.

## TODO

* More tests
* Integrate [parse webhook](http://sendgrid.com/docs/API_Reference/Webhooks/parse.html)

## More Information

* [Gridhook API Documentation](http://injekt.github.com/rdoc/gridhook/)
* [SendGrid Webhooks](http://sendgrid.com/docs/API_Reference/Webhooks/index.html)
* [SendGrid Webhooks/Event](http://sendgrid.com/docs/API_Reference/Webhooks/event.html)
