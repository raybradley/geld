# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  family_id  :integer
#

# an Account (bank, etc) belonging to a Family
#
class Account < ApplicationRecord
  belongs_to :family
  has_many :transactions
  has_many :recurring_transactions

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
end
