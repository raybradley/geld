# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  family_id    :integer
#  account_type :integer
#

# an Account (bank, etc) belonging to a Family
#
class Account < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :recurring_transactions, dependent: :destroy
  belongs_to :family

  enum account_type: {
    checking:    0,
    savings:     1,
    credit_card: 2,
    loan:        3,
  }

  def asset?
    !liability?
  end

  def liability?
    [:credit_card].include? account_type.to_sym
  end

  def balance
    transactions.sum(&:amount)
  end

  # returns the projected balance on a given date, based on
  # recurring transactions on this account
  def balance_on(target_date: nil)
    return unless target_date.present?
    if target_date.future?
      balance + future_transactions(until_date: target_date)
                .inject(0) { |sum, tx| sum + tx.amount }
    else
      transactions.where('occurred_at < ?', target_date.to_date).sum(&:amount)
    end
  end

  # returns recurring transactions on this account up to a target date
  def future_transactions(until_date: nil)
    return unless until_date.present?

    txns = []
    recurring_transactions.each do |rt|
      txns.concat rt.future_instances(until_date: until_date)
    end

    txns.sort_by(&:occurred_at)
  end

  def past_transactions(from_date: nil)
    transactions
      .where('occurred_at >= ?', from_date.to_date)
      .order(:occurred_at).to_a
  end

  def all_transactions(from_date: nil, until_date: nil)
    return [] unless from_date.present? && until_date.present?
    past_transactions(from_date: from_date).concat(
      future_transactions(until_date: until_date)
    )
  end

  # returns an array of daily balances
  def balance_over_time(from_date: nil, until_date: nil)
    raise 'from_date or until_date missing' unless from_date.present? && until_date.present?

    txns = all_transactions(from_date: from_date, until_date: until_date)

    return {from_date: 0} unless txns.count.positive?

    result = {}

    # seed values
    balance = balance_on(target_date: from_date)
    current_date = from_date.to_date
    result[current_date] = balance

    # start from the second array element
    txns.each do |txn|
      while current_date < txn.occurred_at.to_date
        result[current_date] = balance
        current_date += 1.day
      end

      # now we've reached the next transaction
      balance += txn.amount
    end

    while current_date < until_date do
      result[current_date] = balance
      current_date += 1.day
    end

    result
  end  

  def budget?
    name == '*budget'
  end
end
