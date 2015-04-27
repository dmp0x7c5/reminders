class AddChannelNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :channel_name, :string
  end
end
