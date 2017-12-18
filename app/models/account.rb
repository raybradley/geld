class Account < ApplicationRecord
  belongs_to :family
  has_many :transactions
  has_many :recurring_transactions

  def balance
    transactions.sum(&:amount)
  end

  # returns the projected balance on a given date
  def balance_on(target_date: nil)
    return unless target_date.present?

    result = balance
    recurring_transactions.each do |rt|
      txns = rt.future_instances(until_date: target_date)
      txns.each do |txn|
        result += txn.amount
      end
    end

    result
  end
end
