class AddAccountToRecurringTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :recurring_transactions, :account_id, :integer
  end
end
