class CreateBudgetItems < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_items do |t|
      t.integer family_id
      t.integer frequency
      t.timestamps
    end
  end
end
