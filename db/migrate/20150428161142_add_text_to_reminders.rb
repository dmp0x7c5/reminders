class AddTextToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :deadline_text, :string
    add_column :reminders, :notification_text, :string
  end
end
