class ChangeEnumsColumnsTypesForTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :integer
    change_column :tasks, :priority, :integer
  end
end
