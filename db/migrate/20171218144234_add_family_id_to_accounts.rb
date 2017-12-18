class AddFamilyIdToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :family_id, :integer
  end
end
