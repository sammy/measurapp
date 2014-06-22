Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'login', to: 'sessions#new'

  get 'home', to: 'ui#groups'

  resources :sessions, only: [:create]
end
