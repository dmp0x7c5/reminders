require_relative "../sections/project_checks_history_table.rb"

module Reminders
  class ProjectChecksTableRow < SitePrism::Section
    element :project, "td:first"
    element :last_check_date, "td[2]"
    element :last_checker, "td[4]"
    element :history_button, "td[5]"
    element :check_button, "td[6] button"
    element :assigned_reviewer, "td[8]"
    element :pick_random_button, "td[8] button"
    section :history_table, ProjectChecksHistoryTable,
            :xpath, "ancestor::tbody/following-sibling::tbody",
            match: :first

    def id
      root_element[:id]
    end
  end
end
