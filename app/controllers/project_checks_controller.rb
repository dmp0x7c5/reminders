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
