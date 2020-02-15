require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users, controllers: { registrations: 'users/registrations' }, skip: :omniauth_callbacks

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

    resources :user_edits, only: [:edit, :update]
    resources :omni_registrations, only: [:create]
    resources :interests, only: [:create, :new]
    resources :sponsors, only: [:show, :edit, :update]
    resources :businessmen, only: [:show]
    root 'ideas#index'
  end

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
