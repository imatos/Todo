class AddStateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :integer, default: 0
  end
end
