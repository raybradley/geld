snerds = Family.find_or_create_by(name: 'Snerds')
ray    = snerds.users.find_by(email: 'ray.bradley@gmail.com')
if ray.nil?
  snerds.users.create(
    email: 'ray.bradley@gmail.com',
    password: 'spinach',
    password_confirmation: 'spinach'
  )
end

checking    = snerds.accounts.where(name: 'Wells Fargo Checking').first_or_create
credit_card = snerds.accounts.where(name: 'American Express Card').first_or_create
mortgage    = snerds.accounts.where(name: 'Wells Fargo Mortgage').first_or_create

#
# recurring transactions
#
a = checking.recurring_transactions.where(
  starts_at: '2017-03-15',
  frequency: :monthly,
  amount: -215.50,
  description: 'Verizon Wireless'
).first_or_create

checking.recurring_transactions.where(
  starts_at: '2018-03-01',
  frequency: :weekly,
  frequency_multiplier: 2,
  amount: 4567.89,
  description: 'Sema4 Payroll Net'
).first_or_create

checking.recurring_transactions.where(
  starts_at: '2018-03-01',
  frequency: :monthly,
  amount: -522,
  description: 'Con Edison'
).first_or_create

checking.recurring_transactions.where(
  starts_at:   '2018-03-06',
  frequency:   :monthly,
  amount:      -5315.98,
  description: 'Wells Fargo Mortgage',
  to_account:  mortgage
).first_or_create

checking.recurring_transactions.where(
  starts_at: '2018-04-15',
  frequency: :yearly,
  amount: -5315.98,
  description: 'City of New Rochelle School Tax'
).first_or_create

checking.recurring_transactions.where(
  starts_at: '2018-06-15',
  frequency: :yearly,
  amount: -5315.98,
  description: 'City of New Rochelle Property Tax'
).first_or_create

credit_card.recurring_transactions.where(
  starts_at: '2017-01-05',
  frequency: :monthly,
  amount: -200.00,
  description: 'Dry Cleaning'
).first_or_create

checking.recurring_transactions.where(
  starts_at: '2017-01-05',
  frequency: :monthly,
  amount: -1000.00,
  description: 'Payment',
  to_account: credit_card
).first_or_create

#
# budget items
#
credit_card.recurring_transactions.where(
  starts_at: '2017-01-01',
  description: 'Groceries',
  frequency: :monthly,
  amount: -450,
  type: 'BudgetItem'
).first_or_create

#
# past transactions
#
checking.transactions.where(
  occurred_at: 12.months.ago,
  amount: 10987.65,
  description: 'Initial balance'
).first_or_create

checking.transactions.where(
  occurred_at: 1.months.ago,
  amount: -215.50,
  description: 'Verizon Wireless'
).first_or_create

checking.transactions.where(
  occurred_at: 14.days.ago,
  amount: -1000,
  description: 'American Express'
).first_or_create
