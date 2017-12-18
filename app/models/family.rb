class Family < ApplicationRecord
  has_many :users
  has_many :accounts
  has_many :recurring_transactions
end
