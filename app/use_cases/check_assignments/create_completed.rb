module CheckAssignments
  class CreateCompleted < Create
    def call
      create_completed
    end

    private

    def create_completed
      assignment = create_assignment
      Complete.new(
        assignment: assignment,
        checker: checker,
        project_check: project_check,
      ).call
    end
  end
end
