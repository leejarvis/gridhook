module Gridhook
  class EventsController < ActionController::Base
    skip_before_action :verify_authenticity_token, raise: false

    def create
      Gridhook::Event.process(params)
      head :ok
    end
  end
end
