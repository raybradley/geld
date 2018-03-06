# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  occurred_at :date
#  amount      :decimal(8, 2)
#  description :string
#  account_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :transaction do
    occurred_at "2017-12-17"
    amount "9.99"
    description 'A transaction'
    association :account
  end
end
