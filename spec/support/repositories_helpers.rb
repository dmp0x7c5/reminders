module RepositoriesHelpers
  def create_repository(*all)
    repo = InMemoryRepository.new
    repo.all = all
    repo
  end

  def create_check_assignments_repository(*all)
    repo = CheckAssignmentsInMemoryRepository.new
    repo.all = all
    repo
  end
end
