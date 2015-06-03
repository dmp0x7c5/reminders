class PickCheckerService
  attr_reader :users_repository, :latest_checker
  private :users_repository, :latest_checker

  def initialize(args)
    @users_repository = args.fetch(:repository)
    @latest_checker = args.fetch(:latest_checker)
  end

  def call
    pick_random
  end

  private

  def pick_random
    users_repository.all.sample(1).first
  end
end
