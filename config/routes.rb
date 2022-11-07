Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post]
  resources :users
    resources :foods, only: [:index, :new, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
