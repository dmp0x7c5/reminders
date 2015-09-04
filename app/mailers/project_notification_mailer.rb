class ProjectNotificationMailer < ApplicationMailer
  attr_reader :project_check

  def check_reminder(notification, project_check)
    @project_check = project_check
    mail(to: project_email,
         subject: compose_subject) do |format|
      format.text { render inline: notification }
    end
  end

  private

  def compose_subject
    "Reminders: next #{project_check.reminder.name}
    in #{project_check.project.name}"
  end

  def project_email
    project_check.project.decorate.email
  end
end
