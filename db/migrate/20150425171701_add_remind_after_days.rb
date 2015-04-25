class AddRemindAfterDays < ActiveRecord::Migration
  def change
    add_column :reminders, :remind_after_days, :text, array: true, default: []
  end
end
