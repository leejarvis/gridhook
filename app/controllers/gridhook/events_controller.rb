module Gridhook
  class EventsController < ActionController::Base

    before_filter :authenticate

    def create
      Gridhook::Event.process(params)
      head :ok
    end

    private

    def authenticate
      if Gridhook.config.username || Gridhook.config.password
        valid_auth = authenticate_with_http_basic do |username, password|
          Gridhook.config.username == username &&
          Gridhook.config.password == password
        end

        unless valid_auth
          raise (Gridhook.config.auth_error || 'Unauthorized Access')
        end
      end
    end
  end
end
