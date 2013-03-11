module Gridhook
  class EventsController < ActionController::Base
    def create
      Gridhook::Event.process(request.body, params)
      head :ok
    end
  end
end