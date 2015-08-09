module CheckAssignments
  class Delete
    attr_reader :check_assignment_id, :project_check, :check_assignments_repo,
                :users_repo

    def initialize(check_assignment_id:, project_check:,
                   check_assignments_repo: nil, users_repo: nil)
      @check_assignment_id = check_assignment_id
      @project_check = project_check
      @check_assignments_repo = check_assignments_repo ||
                                CheckAssignmentsRepository.new
      @users_repo = users_repo || UsersRepository.new
    end

    def call
      ActiveRecord::Base.transaction do
        remove_from_repo!
        update_project_check!
      end
    end

    private

    def update_project_check!
      last_assignment = check_assignments_repo
                        .latest_assignment(project_check, completed: true)
      if last_assignment.present?
        complete_assignment!(last_assignment)
      else
        ProjectChecks::ClearAssignment.new(check: project_check).call
      end
    end

    def complete_assignment!(assignment)
      CheckAssignments::Complete.new(
        assignment: assignment,
        checker: users_repo.find(assignment.user_id),
        project_check: project_check,
        completion_date: assignment.completion_date,
      ).call
    end

    def remove_from_repo!
      check_assignments_repo.delete(check_assignment_id)
    end
  end
end
