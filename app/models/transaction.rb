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

class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :to_account, class_name: 'Account', optional: true
  belongs_to :recurring_transaction, optional: true
end
