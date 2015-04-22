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
      h.content_tag :span, "no checked yet", class: "label label-danger"
    end
  end
end
