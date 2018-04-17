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

require 'rails_helper'

RSpec.describe BudgetItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
