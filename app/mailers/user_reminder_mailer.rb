class UserReminderMailer < ApplicationMailer
  attr_reader :project_check, :days_diff

  def check_assignment_remind(user, project_check, days_diff)
    @project_check = project_check
    @days_diff = days_diff
    @user = user
    mail(to: user.email,
         cc: project_email,
         subject: compose_subject) do |format|
      format.html
    end
  end

  private

  def compose_subject
    "Reminder: next #{project_check.reminder.name}
    in #{project_check.project.name} is waiting for you!"
  end

  def project_email
    project_check.project.decorate.email
  end
end
