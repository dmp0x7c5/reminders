module CheckAssignments
  class AssignPerson
    attr_reader :check, :assignments_repo, :person

    def initialize(project_check:, assignments_repo:, person:)
      @check = project_check
      @person = person
      @assignments_repo = assignments_repo
    end

    def call
      create_with_assigned_user
      notify_user
      notify_channel(compose_notice)
    end

    private

    def create_with_assigned_user
      CheckAssignments::Create.new(
        checker: person,
        project_check: check,
        assignments_repository: assignments_repo,
      ).call
    end

    def compose_notice
      reminder = check.reminder.name
      project = check.project.name

      "#{person.name} got assigned to do next #{reminder} in #{project}. "
    end

    def notify_channel(message)
      CheckAssignments::Notify.new.call(
        check.project.channel_name,
        message,
      )
    end

    def notify_user
      UserNotificationMailer.check_assignment(@person, @check).deliver
    end
  end
end
