FactoryBot.define do
  factory :transaction do
    occurred_at "2017-12-17"
    amount "9.99"
    description 'A transaction'
    association :account
  end
end
