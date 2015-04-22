class CreateProjectChecks < ActiveRecord::Migration
  def change
    create_table :project_checks do |t|
      t.references :project, index: true, foreign_key: true
      t.references :reminder, index: true, foreign_key: true
      t.date :last_check_date

      t.timestamps null: false
    end
  end
end
