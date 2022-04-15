Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#show"
  resources :buys, only: :show
  namespace :api do
    resources :payments, only: :create
  end
end
