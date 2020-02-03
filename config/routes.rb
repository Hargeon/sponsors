require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :ideas do
    member do
      post 'update_active_time'
    end

    collection do
      post 'search'
      post 'filter'
    end
  end

  resources :interests, only: [:create, :new]
  resources :sponsors, only: [:show, :edit, :update]
  resources :businessmen, only: [:show]
  root 'ideas#index'
  mount Sidekiq::Web => '/sidekiq'
  namespace 'api' do
    namespace 'v1' do
      resources :likes, only: [:create, :destroy]
      resources :dislikes, only: [:create, :destroy]
      resources :ratings, only: [:create]
      resources :autofills, only: [:create]
    end
  end
end
