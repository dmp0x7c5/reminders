class CheckReminderJob < ActiveJob::Base
  queue_as :default
  attr_writer :reminders_repository, :project_checks_repository

  def perform(reminder_id)
    reminder = reminders_repository.find reminder_id
    checks_for_reminder(reminder).each do |check|
      ProjectCheckedOnTimeJob.perform_later(check.id,
                                            reminder.valid_for_n_days,
                                            reminder.remind_after_days)
    end
  end

  private

  def reminders_repository
    @reminders_repository ||= RemindersRepository.new
  end

  def project_checks_repository
    @project_checks_repository ||= ProjectChecksRepository.new
  end

  def checks_for_reminder(reminder)
    project_checks_repository.for_reminder(reminder).select(&:enabled?)
  end
end
