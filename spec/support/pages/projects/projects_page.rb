require_relative "./sections/project_table_row.rb"

module Projects
  class ProjectsPage < SitePrism::Page
    set_url "/projects"
    sections :project_rows, ProjectTableRow, ".row .col-xs-12 table.table tbody tr.projects_list"

    def first_project
      project_rows.first
    end
  end
end
