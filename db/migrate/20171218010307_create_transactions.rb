class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :occurred_at
      t.decimal :amount, precision: 8, scale: 2
      t.string :description
      t.integer :account_id

      t.timestamps
    end

    add_column :recurring_transactions, :description, :string
  end
end
