module CheckAssignments
  class RemindPendingCheckAssignment
    attr_reader :project_check, :users_repository,
                :check_assignments_repository, :reminders_repository

    def initialize(project_check:, users_repository: nil,
                   check_assignments_repository: nil, reminders_repository: nil)
      @project_check = project_check
      @users_repository = users_repository || UsersRepository.new
      @check_assignments_repository = check_assignments_repository ||
                                      CheckAssignmentsRepository.new
      @reminders_repository = reminders_repository || RemindersRepository.new
    end

    def call
      return unless should_remind?
      remind_person
    end

    private

    def remind_person
      UserReminderMailer
        .check_assignment_remind(user, project_check, days_diff)
        .deliver_now
    end

    def check_assignment
      @check_assignment ||= check_assignments_repository
                            .latest_assignment(project_check)
    end

    def user
      users_repository.find(check_assignment.user_id)
    end

    def user_assigned?
      check_assignment.present?
    end

    def should_remind?
      user_assigned? && !user_assigned_today? && !check_assignment_completed?
    end

    def user_assigned_today?
      days_diff == 0
    end

    def check_assignment_completed?
      check_assignment.completion_date.present?
    end

    def days_diff
      @days_diff ||= (Time.zone.today - assignation_date).to_i
    end

    def assignation_date
      check_assignment.created_at.to_date
    end
  end
end
