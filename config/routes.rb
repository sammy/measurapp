Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'login', to: 'sessions#new'
end
