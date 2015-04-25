class AddValidForNDaysToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :valid_for_n_days, :integer, default: 30
  end
end
