Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :accounts
  resources :transactions
  resources :recurring_transactions
end
