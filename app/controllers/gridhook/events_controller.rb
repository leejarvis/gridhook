module Gridhook
  class EmailsController < ActionController::Base
    def create
      Gridlock::Event.process(params)
      head :ok
    end
  end
end