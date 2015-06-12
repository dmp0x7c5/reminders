class CheckAssignmentDecorator < Draper::Decorator
  delegate :completion_date, :created_at

  def checker
    object.user.name
  end
end
