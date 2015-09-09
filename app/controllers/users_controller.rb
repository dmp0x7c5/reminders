class UsersController < ApplicationController
  before_action :authenticate_admin!, except: :toggle_paused_by_user

  expose(:users_repo) { UsersRepository.new }
  expose(:users) do
    UserDecorator.decorate_collection users_repo.active
  end

  def index
  end

  def toggle_admin
    users_repo.toggle_admin(params[:id])
    redirect_to users_url, notice: "User's permissions has been changed."
  end

  def toggle_paused
    paused = users_repo.toggle_paused(params[:id])
    state = (paused) ? "paused" : "unpaused"
    redirect_to users_url, notice: "User has been #{state}."
  end

  def toggle_paused_by_user
    paused = users_repo.toggle_paused(current_user.id)
    state = (paused) ? "paused" : "unpaused"
    redirect_to root_url, notice: "You have been #{state} yourself."
  end
end
