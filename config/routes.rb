Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get]
  # resources :users
    resources :foods, except: [:edit, :update]
    resources :recipes, only: [:index, :show, :new, :create, :destroy] 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
end
