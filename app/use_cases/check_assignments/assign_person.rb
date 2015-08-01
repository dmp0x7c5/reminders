module CheckAssignments
  class AssignPerson
    attr_reader :check, :assignments_repo, :users_repo, :skills_repo

    def initialize(project_check:, assignments_repo:, users_repo:,
                   skills_repo:)
      @check = project_check
      @assignments_repo = assignments_repo
      @users_repo = users_repo
      @skills_repo = skills_repo
    end

    def call(last_checker)
      person = pick_person(last_checker)
      create_with_assigned_user(person)
      notify_channel(compose_notice(person))
    end

    private

    def pick_person(last_checker)
      CheckAssignments::PickPerson.new(
        latest_checker: last_checker,
        users_repository: users_repo,
        skills_repository: skills_repo,
        reminder: check.reminder,
      ).call
    end

    def create_with_assigned_user(person)
      CheckAssignments::Create.new(
        checker: person,
        project_check: check,
        assignments_repository: assignments_repo,
      ).call
    end

    def compose_notice(person)
      user = person.name
      reminder = check.reminder.name
      project = check.project.name

      "#{user} got assigned to do next #{reminder} in #{project}. "
    end

    def notify_channel(message)
      CheckAssignments::Notify.new.call(
        check.project.channel_name,
        message,
      )
    end
  end
end
