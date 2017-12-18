class AddLastOccurredAtToRecurringTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :recurring_transactions, :last_occurred_at, :date
  end
end
