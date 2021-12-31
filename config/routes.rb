Rails.application.routes.draw do
  namespace :users do
    get 'dashboard/index'
  end

  resources :items
  resources :locations

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
end
