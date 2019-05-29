class CreateBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :budgets do |t|
      t.integer :family_id
      t.string :name

      t.timestamps
    end
  end
end
