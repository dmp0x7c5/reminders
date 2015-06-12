module CheckAssignments
  class Create
    attr_reader :checker, :assignments_repository, :project_check
    private :checker, :assignments_repository, :project_check

    def initialize(checker:, project_check:)
      @checker = checker
      @project_check = project_check
      @assignments_repository = CheckAssignmentsRepository.new
    end

    def call
      create_assignment
    end

    private

    def create_assignment
      assignments_repository.add(prepare_attributes)
    end

    def prepare_attributes
      {
        user_id: checker.id,
        project_check_id: project_check.id,
      }
    end
  end
end
