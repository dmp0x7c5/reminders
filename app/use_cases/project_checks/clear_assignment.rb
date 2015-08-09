module ProjectChecks
  class ClearAssignment
    attr_reader :check, :checks_repo
    private :check, :checks_repo

    def initialize(check:, project_checks_repository: nil)
      @check = check
      @checks_repo = project_checks_repository || ProjectChecksRepository.new
    end

    def call
      attrs = {
        last_check_date: nil,
        last_check_user_id: nil,
      }
      checks_repo.update(check, attrs)
    end
  end
end
