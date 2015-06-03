class CheckAssignmentsController < ApplicationController
  expose(:project_checks_repository) { ProjectChecksRepository.new }
  expose(:check) do
    project_checks_repository.find(params[:project_check_id])
  end

  expose(:assignments_repository) { CheckAssignmentsRepository.new }
  expose(:assignment) { assignments_repository.latest_assignment(check) }
  expose(:users_repository) { UsersRepository.new }

  def assign_checker
    checker = PickCheckerService.new(repository: users_repository).call

    AssignmentsService.new(
      checker: checker,
      completed: false,
      project_check_id: check.id,
      assignments: assignments_repository,
    ).call

    redirect_to reminder_path(check.reminder),
                notice: assigned_checker_notice(checker)
  end

  def complete_check
    check_assignment = AssignmentsService.new(
      assignment: assignment,
      checker: current_user,
      completed: true,
      project_check_id: check.id,
      assignments: assignments_repository,
    ).call

    update_project_check(check_assignment) unless check_assignment.nil?

    redirect_to reminder_path(check.reminder), notice: "All right"
  end

  private

  def update_project_check(check_assignment)
    update_params = {
      last_check_date: check_assignment.completion_date,
      last_check_user_id: check_assignment.user_id,
    }

    project_checks_repository.update(check, update_params)
  end

  def assigned_checker_notice(checker)
    "#{checker.name} was assigned to do next
    #{check.reminder.name} in #{check.project.name}"
  end
end
