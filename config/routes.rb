Rails.application.routes.draw do
  devise_for :users
  get "/home" , to: 'home#index'
  get '/user', to: 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
