Rails.application.routes.draw do
  # == ActiveAdmin
  #
  # Used to set up data
  # management in the backend.
  # Accessible to admins only.
  #
  ActiveAdmin.routes(self)

  # == Static Pages
  #
  root   'guests#index'
  get    'welcome', to: 'guests#welcome'

  #== Authentication
  #
  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource  :session,   controller: 'clearance/sessions',  only: [:create]

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: %i[create edit update]
  end

  get    '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  delete '/admin/sign_out' => 'sessions#destroy', as: 'destroy_admin_user_session'
  get    '/sign_up' => 'clearance/users#new', as: 'sign_up'

  # == Core Features
  #
  # Resources which give users
  # their main benefits throughout
  # the app.
  #
  get    'timer', to: 'timers#new'
  resources :timers,    only: %i[new create]
  resources :logs,      only: %i[index new create edit update destroy] do
    resources :replays, only: %i[new create]
  end
  resources :tags, only: %i[index new create destroy]
  resources :histories, only: %i[index]

  # == Sidekiq
  #
  # Set up web interface for
  # background jobs.
  #
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
