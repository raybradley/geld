# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  family_id  :integer
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:account)).to be_valid
  end

  it 'has an initial balance' do
    account = FactoryBot.create(:account)
    expect(account.balance).to eq(account.transactions.sum(&:amount))
  end

  describe 'recurring transactions' do
    let(:account) { FactoryBot.create(:account) }

    it 'has the correct number of recurring_transactions' do
      expect(account.recurring_transactions.count).to eq(2)
    end

    it 'computes the correct future balance' do
      expected_balance  = 0
      expected_balance += account.balance
      expected_balance += account.recurring_transactions.first.amount * 2
      expected_balance += account.recurring_transactions.second.amount
      expect(
        account.balance_on(target_date: 31.days.from_now)
      ).to be_within(0.001).of(expected_balance)
    end
  end
end
