class CreateCheckAssignments < ActiveRecord::Migration
  def change
    create_table :check_assignments do |t|
      t.references :project_check, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.date :completion_date

      t.timestamps null: false
    end
  end
end
