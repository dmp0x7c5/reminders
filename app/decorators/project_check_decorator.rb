class ProjectCheckDecorator < Draper::Decorator
  def project_name
    object.project.name
  end

  def reminder_name
    object.reminder.name
  end

  def last_check_date
    if object.last_check_date.present?
      h.l object.last_check_date
    else
      "not checked yet"
    end
  end

  def css_date_class
    "warning" if object.last_check_date.nil?
  end
end
