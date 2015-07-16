module CheckAssignments
  class AssignPerson
    attr_reader :check, :assignments_repo, :users_repo

    def initialize(project_check:, assignments_repo:, users_repo:)
      @check = project_check
      @assignments_repo = assignments_repo ||
                          CheckAssignmentsRepository.new
      @users_repo = users_repo ||
                    UsersRepository.new
    end

    def assign(last_checker)
      person = pick_person(last_checker)
      create_with_assigned_user(person)
      notify_channel(notice_info(person))
    end

    private

    def pick_person(last_checker)
      CheckAssignments::PickPerson.new(
        latest_checker: last_checker,
        users_repository: users_repo,
      ).call
    end

    def create_with_assigned_user(person)
      CheckAssignments::Create.new(
        checker: person,
        project_check: check,
        assignments_repository: assignments_repo,
      ).call
    end

    def notice_info(person)
      { person: person.name,
        reminder: check.reminder.name,
        project: check.project.name,
      }
    end

    def notify_channel(message)
      CheckAssignments::Notify.new.notify(
        check.project.channel_name,
        message,
      )
    end
  end
end
