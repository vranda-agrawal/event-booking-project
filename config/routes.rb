Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  get "/home" , to: 'home#index'
  get '/user', to: 'home#index'
end
