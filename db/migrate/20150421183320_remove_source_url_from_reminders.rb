class RemoveSourceUrlFromReminders < ActiveRecord::Migration
  def change
    remove_column :reminders, :source_url
  end
end
