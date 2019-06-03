# == Schema Information
#
# Table name: transactions
#
#  id                       :bigint(8)        not null, primary key
#  occurred_at              :date
#  amount                   :decimal(8, 2)
#  description              :string
#  account_id               :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  to_account_id            :integer
#  recurring_transaction_id :integer
#

class FutureTransaction < Transaction
  attr_accessor :recurring_transaction
end
