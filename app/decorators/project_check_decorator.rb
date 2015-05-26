class ProjectCheckDecorator < Draper::Decorator
  delegate :id, :enabled?

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
