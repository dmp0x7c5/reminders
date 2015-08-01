class RemoveAssignableFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :assignable
  end
end
