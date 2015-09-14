class UserNotificationMailer < ApplicationMailer
  def check_assignment(user, project_check)
    @project_check = project_check
    @user = user
    mail(to: user.email,
         subject: compose_subject) do |format|
      format.html
    end
  end

  def compose_subject
    "You have been assigned to do next #{@project_check.reminder.name}
    in #{@project_check.project.name}"
  end
end
