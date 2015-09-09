class CheckAssignmentDecorator < Draper::Decorator
  delegate :completion_date, :created_at, :id

  def checker
    object.user.name
  end

  def row_class
    "active" if completion_date.present?
  end

  def assigned_days_ago
    (Time.zone.today - object.created_at.to_date).to_i
  end

  def assigned_days_ago_as_string
    diff = assigned_days_ago
    if diff == 0
      "today"
    elsif diff == 1
      "#{diff} day ago"
    else
      "#{diff} days ago"
    end
  end
end
