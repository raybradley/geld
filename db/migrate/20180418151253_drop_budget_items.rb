class DropBudgetItems < ActiveRecord::Migration[5.1]
  def change
    drop_table :budget_items
  end
end
