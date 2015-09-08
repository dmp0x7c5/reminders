class AddSlackChannelToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :slack_channel, :string
  end
end
