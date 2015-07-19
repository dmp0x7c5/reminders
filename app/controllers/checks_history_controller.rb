class ChecksHistoryController < ApplicationController
  expose(:project_check) do
    ProjectCheckDecorator.decorate(project_checks_repository.find(params[:id]))
  end
  expose(:project_checks_repository) { ProjectChecksRepository.new }
  expose(:checks) { project_check.check_assignments }

  def index
  end
end
