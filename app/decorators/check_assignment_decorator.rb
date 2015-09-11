class CheckAssignmentDecorator < Draper::Decorator
  delegate :completion_date, :created_at, :id

  def checker
    object.user.name
  end

  def row_class
    "active" if completion_date.present?
  end

  def assigned_days_ago_as_string
    "#{h.time_ago_in_words(object.created_at)} ago"
  end
end
