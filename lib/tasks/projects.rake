namespace :projects do
  desc "Checks for new projects on Slack and synchronises them with app"
  task sync_missing: :environment do
    ActiveRecord::Base.connection_pool.with_connection do
      SyncMissingProjectsJob.new(projects_repo: ProjectsRepository.new,
                                 slack_repo: SlackChannelsRepository.new(Slack.client),
                                 reminders_repo: RemindersRepository.new
                                ).perform
    end
  end
end
