class UsersController < ApplicationController
  before_action :authenticate_admin!

  expose(:users_repo) { UsersRepository.new }
  expose(:users) do
    UserDecorator.decorate_collection users_repo.all
  end

  def index
  end

  def toggle_admin
    users_repo.toggle_admin(params[:id])
    redirect_to users_url, notice: "User's permissions has been changed."
  end
end
