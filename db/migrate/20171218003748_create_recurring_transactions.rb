class CreateRecurringTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :recurring_transactions do |t|
      t.integer :frequency
      t.decimal :amount, precision: 8, scale: 2
      t.date :starts_at
      t.integer :frequency_multiplier, default: 1

      t.timestamps
    end
  end
end
