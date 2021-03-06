# == Schema Information
#
# Table name: transactions
#
#  id                       :bigint(8)        not null, primary key
#  occurred_at              :date
#  amount                   :decimal(8, 2)
#  description              :string
#  account_id               :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  to_account_id            :integer
#  recurring_transaction_id :integer
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:transaction)).to be_valid
  end
end
