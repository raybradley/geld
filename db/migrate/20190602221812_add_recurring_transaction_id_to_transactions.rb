class AddRecurringTransactionIdToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :recurring_transaction_id, :integer
  end
end
