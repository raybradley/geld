Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :accounts, only: [:show, :create]
  resources :transactions
  resources :recurring_transactions
end
