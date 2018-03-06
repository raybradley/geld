# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Family, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:family)).to be_valid
  end

  describe 'future transactions' do
    it 'works' do
      family = FactoryBot.create(:family)
      expect(family.future_transactions(until_date: 6.months.from_now)).to be_a(Array)
    end
  end
end
