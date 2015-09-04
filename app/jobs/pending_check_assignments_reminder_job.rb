class PendingCheckAssignmentsReminderJob
  attr_reader :project_check_id
  attr_writer :project_checks_repository,
              :users_repository, :check_assignments_repository

  def initialize(project_check_id)
    @project_check_id = project_check_id
  end

  def perform
    CheckAssignments::RemindPendingCheckAssignment.new(project_check).call
  end

  private

  def project_check
    @project_check = project_checks_repository.find @project_check_id
  end

  def project_checks_repository
    @project_checks_repository ||= ProjectChecksRepository.new
  end
end
