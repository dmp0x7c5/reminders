class UsersController < ApplicationController
  before_action :authenticate_admin!

  expose(:users_repo) { UsersRepository.new }
  expose(:users) do
    UserDecorator.decorate_collection users_repo.all
  end

  def index
  end
end
