Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index', as: 'root'

  delete '/login', to: 'sessions#destroy', as: 'logout'


  resources :users
  resources :orders
  resources :products, except: [:new, :create, :edit, :update]
  resources :categories
  resources :order_items
  # resources :reviews


  get "/auth/github", as: 'github_login'
  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"

  resources :users do
    resources :products, only: [:new, :create, :edit, :update]
  end

  resources :products do
    resources :reviews, only: [:new, :create]
  end

end
