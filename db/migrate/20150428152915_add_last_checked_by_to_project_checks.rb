class AddLastCheckedByToProjectChecks < ActiveRecord::Migration
  def change
    add_column :project_checks, :last_check_user_id, :integer
  end
end
