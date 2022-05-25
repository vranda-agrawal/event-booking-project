Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "home#index"
  resources :events
  devise_for :users
  resources :customers, :controller => "users"
  get "/home" , to: 'home#index'
  get '/user', to: 'home#index'
  get '/enrol/:id', to: 'events#enrol',as: :enrol
  get '/register/:id',to: 'events#register', as: :register
end
