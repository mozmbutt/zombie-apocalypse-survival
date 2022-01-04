Rails.application.routes.draw do
  resources :trades do
    resources :trade_histories
  end
  
  namespace :users do
    get '/dashboard/index'
    get '/survivors/index'
    resources :infections, only: %i[new create]
  end

  resources :items
  resources :locations, only: %i[show new create index]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
end
