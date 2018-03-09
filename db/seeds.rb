snerds = Family.find_or_create_by(name: 'Snerds')
ray    = snerds.users.find_by(email: 'ray.bradley@gmail.com')
if ray.nil?
  snerds.users.create(
    email: 'ray.bradley@gmail.com',
    password: 'b0ng0d0G',
    password_confirmation: 'b0ng0d0G'
  )
end

checking = snerds.accounts.find_or_create_by(name: 'Wells Fargo Checking')
credit_card = snerds.accounts.find_or_create_by(name: 'American Express Card')

#
# recurring transactions
#
checking.recurring_transactions.create(
  starts_at: '2017-03-15',
  frequency: :monthly,
  amount: -215.50,
  description: 'Verizon Wireless'
)

checking.recurring_transactions.create(
  starts_at: '2018-03-01',
  frequency: :weekly,
  frequency_multiplier: 2,
  amount: 4567.89,
  description: 'Sema4 Payroll Net'
)

checking.recurring_transactions.create(
  starts_at: '2018-03-01',
  frequency: :monthly,
  amount: -522,
  description: 'Con Edison'
)

checking.recurring_transactions.create(
  starts_at: '2018-03-06',
  frequency: :monthly,
  amount: -5315.98,
  description: 'Wells Fargo Mortgage'
)

checking.recurring_transactions.create(
  starts_at: '2018-04-15',
  frequency: :yearly,
  amount: -5315.98,
  description: 'City of New Rochelle School Tax'
)

checking.recurring_transactions.create(
  starts_at: '2018-06-15',
  frequency: :yearly,
  amount: -5315.98,
  description: 'City of New Rochelle Property Tax'
)

credit_card.recurring_transactions.create(
  starts_at: '2017-01-05',
  frequency: :monthly,
  amount: -200.00,
  description: 'Dry Cleaning'
)

#
# budget items
#

#
# past transactions
#
checking.transactions.create(
  occurred_at: 12.months.ago,
  amount: 10987.65,
  description: 'Initial balance'
)

checking.transactions.create(
  occurred_at: 1.months.ago,
  amount: -215.50,
  description: 'Verizon Wireless'
)

checking.transactions.create(
  occurred_at: 14.days.ago,
  amount: -1000,
  description: 'American Express'
)
