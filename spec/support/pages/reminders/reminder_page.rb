require_relative "./sections/project_checks_table_row.rb"

module Reminders
  class ReminderPage < SitePrism::Page
    set_url "/reminders/{reminder_id}"
    sections :project_rows, ProjectChecksTableRow,
             ".row .col-xs-12 table.table tbody.project_row tr"

    def first_project
      project_rows.first
    end
  end
end
