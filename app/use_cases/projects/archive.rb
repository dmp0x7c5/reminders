module Projects
  class Archive
    attr_accessor :project

    def initialize(project)
      self.project = project
    end

    def call
      project.archived_at = Time.current
      project.save!
    end
  end
end
