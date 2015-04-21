class ProjectsController < ApplicationController
  expose(:projects_repository) { ProjectsRepository.new }
  expose(:projects) do
    ProjectDecorator.decorate_collection projects_repository.all
  end

  def index; end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
