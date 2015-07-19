class ProjectHistoryController < ApplicationController
  expose(:project_object) { Project.find(params[:id]) }
  expose(:project) { ProjectDecorator.decorate(project_object) }
  expose(:checks) { project.checks }

  def index
  end
end
