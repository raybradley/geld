Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :accounts do
    resources :transactions
  end
  resources :transactions
  resources :recurring_transactions
end
