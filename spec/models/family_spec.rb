require 'rails_helper'

RSpec.describe Family, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:family)).to be_valid
  end
end
