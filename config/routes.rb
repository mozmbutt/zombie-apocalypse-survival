Rails.application.routes.draw do
  namespace :users do
    get '/dashboard/index'
    get '/dashboard/reports'
    get '/survivors/index'
    resources :infections, only: %i[new create]
  end

  resources :items

  resources :trades do
    resources :trade_histories
  end

  resources :locations, only: %i[show new create index]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
end
