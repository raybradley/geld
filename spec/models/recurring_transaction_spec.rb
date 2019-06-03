# == Schema Information
#
# Table name: recurring_transactions
#
#  id                   :bigint(8)        not null, primary key
#  frequency            :integer
#  amount               :decimal(8, 2)
#  starts_at            :date
#  frequency_multiplier :integer          default(1)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  description          :string
#  account_id           :integer
#  last_occurred_at     :date
#  to_account_id        :integer
#

require 'rails_helper'

RSpec.describe RecurringTransaction, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:recurring_transaction)).to be_valid
  end

  it 'should occur again today' do
    txn = FactoryBot.create(:recurring_transaction)
    expect(txn.next_date).to eq(Date.today)
  end

  it 'should run today' do
    txn = FactoryBot.create(:recurring_transaction)
    expect(txn.today?).to be_truthy
  end

  it 'should not run today' do
    txn = FactoryBot.create(:recurring_transaction, starts_at: Date.today - 1.week)
    expect(txn.today?).to be_falsey
  end
end
