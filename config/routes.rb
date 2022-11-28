Rails.application.routes.draw do
  resources :veganuary_items
  resources :roles
  devise_for :users
  localized do
    resources :articles
    get 'about_me', to: "static_pages#about_me", as: "about_me"
    get 'contact', to: "static_pages#contact", as: "contact"
    get 'support', to: "static_pages#support", as: "support"
  end
  get 'static_pages/welcome'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#welcome"
end
