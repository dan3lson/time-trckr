Rails.application.routes.draw do
  root 'timers#new'
  get 'timer', to: 'timers#new'
  resources :timers, only: %i[new create]
  resources :logs, only: %i[index new create destroy]
end
