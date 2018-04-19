Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'reviews#index', as: 'root'
  resources :users
  resources :orders
  resources :products
  resources :categories
  resources :reviews
end
