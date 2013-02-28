require 'gridhook/unfortunate_sendgrid_fix'

module Gridhook
  class Engine < ::Rails::Engine
    # Insert our SendGrid JSON fix middleware before ParamsParser
    # attempts to encode the JSON.
    config.app_middleware.insert_before ActionDispatch::ParamsParser, 'Gridhook::UnfortunateSendgridFix'
  end
end