# == Schema Information
#
# Table name: recurring_transactions
#
#  id                   :bigint(8)        not null, primary key
#  frequency            :integer
#  amount               :decimal(8, 2)
#  starts_at            :date
#  frequency_multiplier :integer          default(1)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  description          :string
#  account_id           :integer
#  last_occurred_at     :date
#  type                 :string
#  to_account_id        :integer
#

FactoryBot.define do
  factory :recurring_transaction do
    description 'Acme Corp Salary'
    frequency 1 # weekly
    frequency_multiplier 2 # every two weeks
    starts_at Date.today - 4.weeks
    last_occurred_at Date.today - 2.weeks
    amount 6543.21
    association :account
  end
end
