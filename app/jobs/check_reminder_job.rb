class CheckReminderJob
  # NOTE: this is not a regular ActiveJob class - this class is used as an
  # interface to enqueue all the smaller jobs for a given reminder
  attr_writer :reminders_repository, :project_checks_repository

  def perform(reminder_id)
    reminder = reminders_repository.find reminder_id
    checks_for_reminder(reminder).each do |check|
      ProjectCheckedOnTimeJob.new(check.id,
                                  reminder.valid_for_n_days,
                                  reminder.remind_after_days).perform
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
    project_checks_repository.for_reminder(reminder).select do |project_check|
      project_check.enabled? &&
        project_check.check_assignments.none? { |c| c.completion_date.nil? }
    end
  end
end
