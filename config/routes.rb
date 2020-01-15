require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :ideas
  resources :interests, only: [:create, :new]
  resources :sponsors, only: [:show, :edit, :update]
  resources :businessmans, only: [:show]
  root 'ideas#index'
  mount Sidekiq::Web => '/sidekiq'
end
