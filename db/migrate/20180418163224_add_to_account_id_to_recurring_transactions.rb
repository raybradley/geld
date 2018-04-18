class AddToAccountIdToRecurringTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :recurring_transactions, :to_account_id, :integer
  end
end
