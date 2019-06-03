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
#  to_account_id        :integer
#

# a recurring transaction stores things that happen
# on a regular basis
#
class RecurringTransaction < ApplicationRecord
  belongs_to :account
  belongs_to :to_account, class_name: 'Account', optional: true

  enum frequency: {
    daily: 0,
    weekly: 1,
    monthly: 2,
    yearly: 3
  }

  def family
    account.family
  end

  def transaction_type
    self[:amount].positive? ? :credit : :debit
  end

  def debit?
    transaction_type == :debit
  end

  def credit?
    transaction_type == :credit
  end

  def amount_abs
    self[:amount].abs
  end

  def amount_abs=(value)
    value = value.to_f

    if debit?
      puts 'debiting'
      self.amount = -value
    else
      self.amount = value
    end
  end

  # returns a Transaction
  def next_instance(after: starts_at)
    occurred_at = next_date(after: after)

    txn = FutureTransaction.new(
      occurred_at: occurred_at,
      description: description,
      amount:      amount,
      account:     account,
      to_account:  to_account
    )

    txn.recurring_transaction = self

    txn
  end

  # when will it run again? If it's happened before,
  # the next date will honor the recurrence scheme. If it
  # hasn't happened before, it'll return the next date after
  # today based on the recurrence scheme
  def next_date(after: nil)
    after ||= Date.today
    # result = after # <- bogus
    result = starts_at # <- correct
    until result > after
      increment = frequency_multiplier.day   if daily?
      increment = frequency_multiplier.week  if weekly?
      increment = frequency_multiplier.month if monthly?
      increment = frequency_multiplier.year  if yearly?
      result += increment
    end
    result
  end

  # create all instances from a particular date until now
  # NOTE: it doesn't care whether the from_date is consistent
  # with the recurrence scheme
  def create_instances_to_now(from_date: nil)
    return unless from_date.present?
    from_date = DateTime.parse from_date if from_date.is_a?(String)
    return unless from_date.is_a? DateTime

    the_date = from_date

    # loop until the next 
    until the_date.future?
      unless self.account.transactions.exists?(recurring_transaction_id: self.id, occurred_at: the_date)
        create_instance(occurred_at: the_date)
      end

      the_date = next_date(after: the_date)
    end
  end

  # create an instance of the transaction on a particular date
  # NOTE: it doesn't care whether the supplied date is consistent with
  # the recurrence scheme
  def create_instance(occurred_at: nil)
    return unless occurred_at.present?

    self.account.transactions.create!(
      occurred_at:           occurred_at,
      amount:                self.amount,
      description:           self.description,
      recurring_transaction: self
    )

    last_occurred_at = [last_occurred_at, occurred_at].max
    self.save!
  end

  # return all instances of this recurring transactions
  def instances
    self.account.transactions.where(recurring_transaction_id: self.id)
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
