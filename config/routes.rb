Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root              to: 'sessions#new'
  get 'login',      to: 'sessions#new'

  get 'home',       to: 'groups#index'

  get 'register',   to: 'users#new'

  delete 'logout',  to: 'sessions#destroy'

  resources :sessions, only: [:create]

  resources :groups, only: [:index, :new]

  resources :users, only: [:create]

  resources :items, only: [:new, :create]
end
