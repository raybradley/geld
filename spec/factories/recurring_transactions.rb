FactoryBot.define do
  factory :recurring_transaction do
    description 'Acme Corp Salary'
    frequency 1 # weekly
    frequency_multiplier 2 # every two weeks
    starts_at Date.today - 1.week
    amount 6543.21
    association :account
  end
end
