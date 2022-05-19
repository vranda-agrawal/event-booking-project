Rails.application.routes.draw do
  root "home#index"
  resources :events
  devise_for :users
  resources :customers, :controller => "users"
  get "/home" , to: 'home#index'
  get '/user', to: 'home#index'
  get '/enrol/:id', to: 'events#enrol',as: :enrol
end
