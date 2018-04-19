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
#  to_account_id        :integer
#

class BudgetItem < RecurringTransaction
end
