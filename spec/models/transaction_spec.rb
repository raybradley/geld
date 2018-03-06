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

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:transaction)).to be_valid
  end
end
