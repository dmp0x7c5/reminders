class ProjectDecorator < Draper::Decorator
  delegate :id, :name

  def created_at
    h.l object.created_at
  end

  def channel_name
    "##{object.channel_name}"
  end

  def checked_reviews
    ::ProjectCheckDecorator.decorate_collection object.checked_reviews
  end

  def checks
    ::ProjectCheckDecorator.decorate_collection object.project_checks
  end

  def checks_per_reminder(reminder_id)
    ::ProjectCheckDecorator.decorate_collection object
      .project_checks
      .order(created_at: :desc)
      .select { |c| c.reminder_id == reminder_id }
  end

  def has_checked_reviews?
    checked_reviews.any?
  end

  def show_history
    if project.checked_reviews.count > 0
      h.content_tag :div, "Show", class: ["toggle_history", "btn", "btn-success", "center"]
    else
      "nothing to show"
    end
  end
end
