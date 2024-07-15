Rails.application.routes.draw do
  resources :notes do
    get 'search', on: :collection
  end
end
