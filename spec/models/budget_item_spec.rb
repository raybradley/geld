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
#  type                 :string
#  to_account_id        :integer
#

require 'rails_helper'

RSpec.describe BudgetItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
