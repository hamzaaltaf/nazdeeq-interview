class AddSprintToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :sprint, :integer, default: 0
    add_index :tasks, :sprint
  end
end
