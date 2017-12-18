Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :accounts, only: :create
  resources :transactions, only: :create
  resources :recurring_transactions, only: :create
end
