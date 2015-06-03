class PickCheckerService
  attr_reader :users_repository
  private :users_repository

  def initialize(args)
    @users_repository = args.fetch(:repository)
  end

  def call
    pick_random
  end

  private

  def pick_random
    users_repository.all.sample(1).first
  end
end
