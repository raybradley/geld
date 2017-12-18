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
