module Gridhook
  class EventsController < ActionController::Base
    def create
      Gridhook::Event.process(params)
      head :ok
    end
  end
end