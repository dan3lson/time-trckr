Rails.application.routes.draw do
  root 'logs#new'
  get 'timer', to: 'logs#new'
  resources :logs, only: %i[index new create]
end
