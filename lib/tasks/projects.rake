namespace :projects do
  desc "Checks for new projects on Slack and synchronises them with app"
  task sync_missing: :environment do
    ActiveRecord::Base.connection_pool.with_connection do
      SyncMissingProjectsJob.new(
        projects_repo: ProjectsRepository.new,
        slack_repo: SlackChannelsRepository.new(Slack.client),
        reminders_repo: RemindersRepository.new,
        checks_repo: ProjectChecksRepository.new,
      ).perform
    end
  end

  desc "Add email to projects"
  task migrate_emails: :environment do
    projects = ProjectsRepository.new.all
    projects.each do |project|
      project.update_column(:email, prepare_project_email(project.name))
    end
  end

  private

  def prepare_project_email(name)
    "#{name.downcase}-team@#{AppConfig.domain}"
  end
end
