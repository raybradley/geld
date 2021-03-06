# == Schema Information
#
# Table name: budgets
#
#  id         :bigint(8)        not null, primary key
#  family_id  :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :budget do
    family_id { 1 }
    name { "MyString" }
  end
end
