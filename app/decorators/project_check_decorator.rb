class ProjectCheckDecorator < Draper::Decorator
  delegate :id, :enabled?, :last_check_user, :project_id, :reminder_id
  decorates_association :check_assignments

  def project_name
    object.project.name
  end

  def last_check_date
    if object.last_check_date.present?
      "#{h.l(object.last_check_date)} (#{last_check_date_time_diff})"
    else
      "not checked yet"
    end
  end

  def css_date_class
    if !object.enabled?
      "active"
    elsif object.last_check_date.nil?
      "warning"
    elsif days_to_deadline_as_number <= 0
      "danger"
    end
  end

  def css_disabled_state
    '<i class="glyphicon glyphicon-time"></i>'
  end

  def days_to_deadline_as_number
    to_date = object.last_check_date || object.created_at.to_date
    to_date += object.reminder.valid_for_n_days.days
    from_date = Time.zone.today
    (to_date - from_date).to_i
  end

  def days_to_deadline
    if days_to_deadline_as_number > 0
      days_to_deadline_as_number
    else
      "after deadline"
    end
  end

  def last_checked_by
    object.last_check_user.name if object.last_check_user.present?
  end

  def review
    object.reminder.name
  end

  def assignments
    return check_assignments[1..-1] if has_appointed_review?
    check_assignments
  end

  def assignments_table_size
    assignments.count + 3
  end

  def has_no_checks?
    check_assignments.empty?
  end

  def has_appointed_review?
    latest_assignment.completion_date.nil? unless has_no_checks?
  end

  def latest_assignment
    object.check_assignments.first.decorate unless has_no_checks?
  end

  def latest_completed_check
    assignments.first
  end

  def assigned_reviewer
    latest_assignment.checker if has_appointed_review?
  end

  private

  def last_check_date_time_diff
    date_diff_in_words object.last_check_date
  end

  def date_diff_in_words(from_date, to_date = Time.zone.today)
    days_diff = (to_date - from_date).to_i
    case days_diff
    when 0 then "today"
    when 1 then "yesterday"
    else
      h.pluralize(days_diff, "day") + " ago"
    end
  end
end
