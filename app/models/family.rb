# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Family < ApplicationRecord
  has_many :users
  has_many :accounts
  has_many :recurring_transactions

  # returns recurring transactions on this family up to a target date
  def future_transactions(until_date: nil)
    return unless until_date.present?

    txns = []

    accounts.each do |account|
      account.recurring_transactions.each do |rt|
        txns.concat rt.future_instances(until_date: until_date)
      end
    end

    txns.sort_by(&:occurred_at)
  end

  # transactions past a given date
  def past_transactions(from_date: nil)
    return unless from_date.present?
    txns = []
    accounts.each do |account|
      txns.concat account.past_transactions(from_date: from_date)
    end

    txns.sort_by(&:occurred_at)
  end

  # all past and future transactions between two dates
  def transactions(from_date: nil, until_date: nil)
    return unless from_date.present? && until_date.present?
    past_transactions(from_date: from_date).concat future_transactions(until_date: until_date)
  end

  def balance
    accounts.inject(0) { |balance, account| balance + account.balance }
  end

  def balance_on(target_date: nil)
    balance = 0
    accounts.each do |account|
      balance += account.balance_on(target_date: target_date)
    end
    balance
  end
end
