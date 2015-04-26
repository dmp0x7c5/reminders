class RemoveIntervalFromReminders < ActiveRecord::Migration
  def change
    remove_column :reminders, :interval
  end
end
