# == Schema Information
#
# Table name: accounts
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  family_id  :integer
#  type       :string
#

class CheckingAccount < AssetAccount
end
