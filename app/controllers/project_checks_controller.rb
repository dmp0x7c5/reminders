class ProjectChecksController < ApplicationController
  expose(:project_checks_repository) { ProjectChecksRepository.new }
  expose(:check) { project_checks_repository.find(params[:id]) }

  def update
    check.last_check_date = Time.current.to_date
    check.save

    redirect_to reminder_path(check.reminder), notice: "All right!"
  end
end
