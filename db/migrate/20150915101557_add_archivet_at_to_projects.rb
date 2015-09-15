class AddArchivetAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :archived_at, :datetime
  end
end
