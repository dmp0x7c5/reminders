class AddEnabledToProjectChecks < ActiveRecord::Migration
  def change
    add_column :project_checks, :enabled, :boolean, default: true
  end
end
