class ProjectCheckedOnTimeJob < ActiveJob::Base
  queue_as :default
  attr_accessor :project_check
  attr_writer :project_checks_repository

  def perform(project_check_id, valid_for_n_days, remind_after_days)
    self.project_check = project_checks_repository.find project_check_id
    if overdue? valid_for_n_days
      ProjectChecks::HandleOverdue.new(project_check, days_diff).call
    elsif notify? remind_after_days
      ProjectChecks::HandleNotificationDay.new(project_check, days_diff).call
    end
  end

  private

  def project_checks_repository
    @project_checks_repository ||= ProjectChecksRepository.new
  end

  def notify?(remind_after_days)
    remind_after_days.any? { |day| day == days_diff }
  end

  def overdue?(valid_for_n_days)
    days_diff > valid_for_n_days
  end

  def days_diff
    @days_diff ||= (Time.zone.today - last_check_date).to_i
  end

  def last_check_date
    project_check.last_check_date || project_check.created_at.to_date
  end
end
