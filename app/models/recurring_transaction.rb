# a recurring transaction stores things that happen
# on a regular basis
#
class RecurringTransaction < ApplicationRecord
  belongs_to :account

  enum frequency: {
    daily: 0,
    weekly: 1,
    monthly: 2,
    yearly: 3
  }

  # returns a Transaction
  def next_instance(after: nil)
    after = starts_at unless after.present?
    next_date = starts_at
    until next_date > after
      next_date += frequency_multiplier.day   if daily?
      next_date += frequency_multiplier.week  if weekly?
      next_date += frequency_multiplier.month if monthly?
      next_date += frequency_multiplier.year  if yearly?
    end
    Transaction.new(
      occurred_at: next_date,
      description: description,
      amount: amount
    )
  end

  # returns an array of Transactions
  def future_instances(after: Date.today, until_date: 1.year.from_now)
    result = []
    txn = next_instance(after: after)
    until txn.occurred_at > until_date
      result << txn
      txn = next_instance(after: txn.occurred_at)
    end
    result
  end
end
