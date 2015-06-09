class PickCheckerService
  attr_reader :users_repository, :latest_checker
  private :users_repository, :latest_checker

  def initialize(data)
    @users_repository = UsersRepository.new
    @latest_checker = data.fetch(:latest_checker)
  end

  def call
    available_users.sample(1).first
  end

  private

  def available_users
    users_repository.all.to_a - [latest_checker]
  end
end
