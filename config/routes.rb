Rails.application.routes.draw do
  namespace :users do
    get '/dashboard/index'
    get '/dashboard/reports'
    get '/survivors/index'
    resources :infections, only: [:create]
  end

  resources :items

  resources :trades, only: [:index, :new, :create, :update] do
    resources :trade_histories,only: [:index]
  end

  resources :locations, only: [:new, :create, :index]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
end
