# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :family do
    name 'The Snerds'

    after(:create) do |family, evaluator|
      create_list(:account, 1, family: family)
    end
  end
end
