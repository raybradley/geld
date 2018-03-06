FactoryBot.define do
  factory :account do
    family
    name 'Wells Fargo'

    after(:create) do |account, _evaluator|
      account.transactions.create(
        description: 'Initial balance',
        occurred_at: DateTime.now,
        amount: 1234.56
      )
      account.recurring_transactions.create(
        starts_at: Date.today,
        frequency: :weekly,
        frequency_multiplier: 2,
        amount: 4000.0
      )
      account.recurring_transactions.create(
        starts_at: Date.today,
        frequency: :monthly,
        amount: -100.0
      )
    end
  end
end
