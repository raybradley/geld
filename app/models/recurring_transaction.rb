# == Schema Information
#
# Table name: recurring_transactions
#
#  id                   :integer          not null, primary key
#  frequency            :integer
#  amount               :decimal(8, 2)
#  starts_at            :date
#  frequency_multiplier :integer          default(1)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  description          :string
#  account_id           :integer
#  last_occurred_at     :date
#

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

  def transaction_type
    self[:amount].positive? ? :credit : :debit
  end

  def debit?
    transaction_type == :debit
  end

  def credit?
    transaction_type == :credit
  end

  def amount
    self[:amount].abs
  end

  # returns a Transaction
  def next_instance(after: starts_at)
    txn = FutureTransaction.new(
      occurred_at: next_date(after: after),
      description: description,
      amount: amount,
      account: account
    )

    txn.recurring_transaction = self

    txn
  end

  # when will it run again?
  def next_date(after: nil)
    after ||= last_occurred_at || Date.today
    result = starts_at
    until result > after
      increment = frequency_multiplier.day   if daily?
      increment = frequency_multiplier.week  if weekly?
      increment = frequency_multiplier.month if monthly?
      increment = frequency_multiplier.year  if yearly?
      result += increment
    end
    result
  end

  # when would it have run previously?
  def previous_date(before: Date.today)
    result = starts_at
    result = next_date(after: result) until next_date(after: result) > before
    result
  end

  # should it run today?
  def today?
    next_date == Date.today
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

  def budget_item?
    account.budget?
  end
end
