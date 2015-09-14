module RepositoriesHelpers
  def create_repository(*all)
    repo = InMemoryRepository.new
    repo.all = all
    repo
  end
end
