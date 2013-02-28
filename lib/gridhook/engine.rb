require 'gridhook/unfortunate_sendgrid_fix'

module Gridhook
  class Engine < ::Rails::Engine
    config.app_middleware.insert_before ActionDispatch::ParamsParser, 'UnfortunateSendgridFix'
  end
end