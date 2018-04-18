Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :accounts, only: [:show, :create]
  resources :transactions, only: [:show, :create]
  resources :recurring_transactions, only: [:show, :create]
end
