module ProjectChecks
  class Update
    attr_reader :check, :checks_repository
    private :check, :checks_repository

    def initialize(check:)
      @check = check
      @checks_repository = ProjectChecksRepository.new
    end

    def call(parameters)
      checks_repository.update(check, parameters)
    end
  end
end
