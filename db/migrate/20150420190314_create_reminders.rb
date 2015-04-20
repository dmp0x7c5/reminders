class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.integer :interval
      t.string :source_url

      t.timestamps null: false
    end
  end
end
