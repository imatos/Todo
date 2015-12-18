class AddStateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :integer, defaukt: 0
  end
end
