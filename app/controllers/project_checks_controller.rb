class ProjectChecksController < ApplicationController
  expose(:project_checks_repository) { ProjectChecksRepository.new }
  expose(:check) do
    project_checks_repository.find(
      params[:id] || params[:project_check_id],
    )
  end

  def update
    check.last_check_date = Time.current.to_date
    check.last_check_user = current_user
    check.save

    redirect_to reminder_path(check.reminder), notice: "All right!"
  end

  def toggle_state
    check.enabled = !check.enabled
    check.save

    redirect_to reminder_path(check.reminder), notice: "All right!"
  end
end
