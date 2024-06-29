require 'sidekiq'
require 'sidekiq/web'

Rails.application.routes.draw do
  get 'reports/balance'
  get 'dashboard/index'
  
  resources :payments
  devise_for :users

  resources :debts, except: %i(edit update show)

  resources :people do
    collection do
      get :search
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  # Health Check
  get "up" => "rails/health#show", as: :rails_health_check

  # Libs
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Root
  root 'dashboard#index'
end
