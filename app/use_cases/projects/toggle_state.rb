module Projects
  class ToggleState
    attr_reader :project, :projects_repository,
                :checks_repository

    def initialize(project:, projects_repository:, checks_repository:)
      @project = project
      @projects_repository = projects_repository
      @checks_repository = checks_repository
    end

    def toggle
      if project.enabled
        disable_project
      else
        enable_project
      end
    end

    private

    def disable_project
      projects_repository.update(project, enabled: false)
      toggle_project_checks(flag_value: false)
    end

    def enable_project
      projects_repository.update(project, enabled: true)
      toggle_project_checks(flag_value: true)
    end

    def toggle_project_checks(flag_value:)
      project.project_checks.each do |pc|
        checks_repository.update(pc, enabled: flag_value)
      end
    end
  end
end
