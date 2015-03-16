module Gridhook
  class Engine < ::Rails::Engine
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/gridhook/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end