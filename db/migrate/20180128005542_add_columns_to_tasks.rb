class AddColumnsToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :assigned_at, :datetime
    add_column :tasks, :completed_at, :datetime
    add_column :tasks, :time_taken, :integer
    add_column :tasks, :dev_status, :integer, default: 0
    add_index :tasks, :dev_status 
    add_column :tasks, :qa_status, :integer, default: 0
    add_index :tasks, :qa_status
    add_column :tasks, :priority, :integer, default: 0
    add_index :tasks, :priority
    add_column :tasks, :category, :integer, default: 0
    add_index :tasks, :category
    add_column :tasks, :environment, :integer, default: 0
    add_index :tasks, :environment
    add_column :tasks, :comments, :text
    add_column :tasks, :times_repeated, :integer
    add_column :tasks, :is_deleted, :boolean, default: false
    add_column :tasks, :unit_tested, :boolean, default: false
    add_column :tasks, :unit_tests_started, :datetime
    add_column :tasks, :assigned_to, :integer, default: 0
    add_index :tasks, :assigned_to
    add_column :tasks, :product_type, :integer, default: 0
    add_index :tasks, :product_type
    add_column :tasks, :caused_by, :integer, default: 0
    add_column :tasks, :started_at, :datetime
    add_column :tasks, :level, :integer, default: 0
    add_column :tasks, :reported_by, :integer, default: 0
    add_column :tasks, :reported_at, :datetime
    add_column :tasks, :sprint, :integer, default: 0
  end
end
