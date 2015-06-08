class CheckAssignmentsController < ApplicationController
  expose(:project_checks_repository) { ProjectChecksRepository.new }
  expose(:check) do
    project_checks_repository.find(params[:project_check_id])
  end
  expose(:assignments_repository) { CheckAssignmentsRepository.new }
  expose(:assignment) { assignments_repository.latest_assignment(check) }
  expose(:last_checker) do
    assignment.nil? ? nil : assignment.user
  end
  expose(:action_resolver) do
    CheckAssignments::ResolveAction.new(assignment: assignment)
  end

  def assign_checker
    if action_resolver.can_create?
      checker = create_with_assigned_user
      redirect_to reminder_path(check.reminder),
                  notice: assigned_checker_notice(checker)
    else
      redirect_to reminder_path(check.reminder),
                  notice: "Someone is already assigned to do this"
    end
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
  def create_with_assigned_user
    checker = PickCheckerService.new(latest_checker: last_checker).call
    CheckAssignments::Create.new(
      checker: checker,
      project_check: check,
    ).call
    checker
  end

  def assigned_checker_notice(checker)
    "#{checker.name} was assigned to do next
    #{check.reminder.name} in #{check.project.name}"
  end
end
