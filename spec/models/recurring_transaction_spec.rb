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
