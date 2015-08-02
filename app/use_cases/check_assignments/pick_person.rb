module CheckAssignments
  class PickPerson
    attr_reader :users_repository, :latest_checker, :skills_repo, :reminder
    private :users_repository, :latest_checker

    def initialize(latest_checker:, users_repository:, reminder:,
                   skills_repository:)
      @users_repository = users_repository
      @latest_checker = latest_checker
      @skills_repo = skills_repository
      @reminder = reminder
    end

    def call
      if available_users.none?
        raise StandardError, "no user with skill required for #{reminder.name}"
      end
      available_users.sample(1).first
    end

    private

    def available_users
      @available_users ||= filter_users
    end

    def filter_users
      user_ids = skills_repo.user_ids_for_reminder(reminder)
      (users_repository.all.to_a - [latest_checker]).select do |u|
        user_ids.include?(u.id)
      end
    end
  end
end
