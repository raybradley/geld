# == Schema Information
#
# Table name: budget_items
#
#  id         :integer          not null, primary key
#  family_id  :integer
#  frequency  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BudgetItem < ApplicationRecord
end
