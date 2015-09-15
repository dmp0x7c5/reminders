class ProjectChecksController < ApplicationController
  expose(:project_checks_repository) { ProjectChecksRepository.new }
  expose(:check) do
    project_checks_repository.find(
      params[:id] || params[:project_check_id],
    )
  end
  expose(:reminders_repository) { RemindersRepository.new }
  expose(:reminder) do
    reminders_repository.find(params[:reminder_id])
  end
  expose(:users) { UsersWithSkillRepository.new(reminder).active }
  expose(:assignments_repo) { CheckAssignmentsRepository.new }
  expose(:users_repo) { UsersRepository.new }

  def pick_person
    last_checker = assignments_repo.latest_assignment(check).try(:user)
    self.reminder = check.reminder
    user_assigner = UserAssigner.new(reminder, users, last_checker)
    self.users = UserAssignerResultDecorator.decorate_collection(
      user_assigner.results)
  end

  def reassign_person
    latest_assignment = assignments_repo.latest_assignment(check)
    notice = CheckAssignments::Cancel.new(latest_assignment).call
    redirect_to project_check_pick_person_path(check),
                notice: notice
  end

  def assign_checker
    notice = CheckAssignments::AssignPerson.new(
      project_check: check,
      assignments_repo: assignments_repo,
      person: users_repo.find(params[:user_id]),
    ).call
    redirect_to reminder_path(check.reminder),
                notice: notice
  end

  # rubocop:disable Metrics/AbcSize
  def toggle_state
    check.enabled = !check.enabled
    if check.save
      redirect_to reminder_path(check.reminder), notice: "All right!"
    else
      redirect_to reminder_path(check.reminder),
                  alert: check.errors.full_messages.join(", ")
    end
  end
  # rubocop:enable Metrics/AbcSize
end
