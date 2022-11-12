Rails.application.routes.draw do
  resources :roles
  devise_for :users
  resources :articles
  get 'static_pages/welcome'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#welcome"
end
