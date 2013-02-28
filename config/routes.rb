Rails.application.routes.draw do
  post Gridhook.config.event_receive_path => 'gridhook/events#create'
end