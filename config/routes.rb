Rails.application.routes.draw do
  resources :notes do
    get "search", on: :collection
    post "import_from_external_service", on: :collection
  end
end
