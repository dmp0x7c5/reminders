module Projects
  class Update
    attr_accessor :attrs, :projects_repo, :project

    def initialize(project:, attrs:, projects_repo: ProjectsRepository.new)
      self.project = project
      self.attrs = attrs
      self.projects_repo = projects_repo
    end

    def call
      if projects_repo.update(project, attrs)
        Response::Success.new data: project
      else
        Response::Error.new data: project
      end
    end
  end
end
