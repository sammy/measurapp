Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root              to: 'sessions#new'
  
  get 'login',      to: 'sessions#new'

  get 'home',       to: 'groups#index'

  get 'register',   to: 'users#new'

  delete 'logout',  to: 'sessions#destroy'

  resources :sessions, only: [:create]

  resources :groups do
    get 'measure(/:measure)', action: 'measure', on: :member, as: 'measure'
  end

  resources :users, only: [:create]

  resources :items

  resources :measures
end
