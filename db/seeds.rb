snerds = Family.find_or_create_by(name: 'Snerds')
ray    = snerds.users.find_by(email: 'ray.bradley@gmail.com')
if ray.nil?
  snerds.users.create(
    email: 'ray.bradley@gmail.com',
    password: 'b0ng0d0G',
    password_confirmation: 'b0ng0d0G'
  )
end

wfb = snerds.accounts.find_or_create_by(name: 'Wells Fargo')
wfb.recurring_transactions.create(
  starts_at: '2017-03-15',
  frequency: :monthly,
  amount: -215.50,
  description: 'Verizon Wireless'
)

wfb.recurring_transactions.create(
  starts_at: '2018-03-01',
  frequency: :weekly,
  frequency_multiplier: 2,
  amount: 4567.89,
  description: 'Sema4 Payroll Net'
)

wfb.recurring_transactions.create(
  starts_at: '2018-03-01',
  frequency: :monthly,
  amount: -522,
  description: 'Con Edison'
)

wfb.recurring_transactions.create(
  starts_at: '2018-03-06',
  frequency: :monthly,
  amount: -5315.98,
  description: 'Wells Fargo Mortgage'
)

wfb.recurring_transactions.create(
  starts_at: '2018-04-15',
  frequency: :yearly,
  amount: -5315.98,
  description: 'City of New Rochelle School Tax'
)

wfb.recurring_transactions.create(
  starts_at: '2018-06-15',
  frequency: :yearly,
  amount: -5315.98,
  description: 'City of New Rochelle Property Tax'
)

wfb.transactions.create(
  occurred_at: 12.months.ago,
  amount: 10987.65,
  description: 'Initial balance'
)

wfb.transactions.create(
  occurred_at: 1.months.ago,
  amount: -215.50,
  description: 'Verizon Wireless'
)

wfb.transactions.create(
  occurred_at: 14.days.ago,
  amount: -1000,
  description: 'American Express'
)
