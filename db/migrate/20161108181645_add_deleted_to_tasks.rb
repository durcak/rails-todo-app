class AddDeletedToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :deleted_at, :datetime
    add_reference :tasks, :name, required: true
  end
end
