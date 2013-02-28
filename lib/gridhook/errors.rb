module Gridhook
  class Error < StandardError
  end

  # Raised if Gridhook.config.event_processor does not respond to #call.
  class InvalidEventProcessor < Error
  end
end