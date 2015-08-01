class SyncMissingProjectsJob
  attr_reader :slack_channels_repository,
              :projects_repository,
              :reminders_repository,
              :project_checks_repository

  def initialize(projects_repo:, slack_repo:, reminders_repo:, checks_repo:)
    @projects_repository = projects_repo
    @slack_channels_repository = slack_repo
    @reminders_repository = reminders_repo
    @project_checks_repository = checks_repo
  end

  def perform
    return unless AppConfig.slack_enabled
    sync_projects
    sync_with_reminders
  end

  private

  def sync_projects
    Projects::SyncWithSlackChannels
      .new(projects_repository, slack_channels_repository)
      .call
  end

  def sync_with_reminders
    reminders_repository.all.each do |reminder|
      Reminders::SyncProjects
        .new(reminder, projects_repository, project_checks_repository)
        .call
    end
  end
end
