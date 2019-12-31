Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :ideas
  resources :interests, only: [:create]
  resources :sponsors, only: [:show]
  resources :businessmans, only: [:show]
  root 'ideas#index'
end
