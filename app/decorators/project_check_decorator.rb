class ProjectCheckDecorator < Draper::Decorator
  delegate :id

  def project_name
    object.project.name
  end

  def last_check_date
    if object.last_check_date.present?
      date_diff_in_words object.last_check_date
    else
      "not checked yet"
    end
  end

  def css_date_class
    "warning" if object.last_check_date.nil?
  end

  def css_disabled_state
    '<i class="glyphicon glyphicon-time"></i>'
  end

  def days_to_deadline
    to_date = object.last_check_date || object.created_at.to_date
    to_date += object.reminder.valid_for_n_days.days
    from_date = Time.zone.today
    days_diff = (to_date - from_date).to_i
    days_diff > 0 ? days_diff : "after deadline"
  end

  def last_checked_by
    object.last_check_user.name if object.last_check_user.present?
  end

  private

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
