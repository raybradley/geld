require 'rails_helper'

RSpec.describe RecurringTransaction, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:recurring_transaction)).to be_valid
  end
end
