class RenameAccountTypeField < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :type, :string
    remove_column :accounts, :account_type
  end
end
