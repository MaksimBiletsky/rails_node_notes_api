require "resque/server"
require 'resque/scheduler/server'

Rails.application.routes.draw do
  resources :notes do
    get "search", on: :collection
    post "import_from_external_service", on: :collection
  end
  resources :api_logs do 
    get "search", on: :collection
  end

  mount Resque::Server.new, at: "/jobs"
end
