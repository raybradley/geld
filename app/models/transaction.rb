# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  occurred_at :date
#  amount      :decimal(8, 2)
#  description :string
#  account_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Transaction < ApplicationRecord
  belongs_to :account
end
