class ProjectDecorator < Draper::Decorator
  delegate :id, :name, :enabled

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

  def has_checked_reviews?
    checked_reviews.any?
  end

  def history_rowspan_size
    checks.count + 2
  end

  def show_history
    if project.checked_reviews.count > 0
      h.content_tag :div, "Show",
                    class: ["toggle_history", "btn", "btn-success", "center"]
    else
      "nothing to show"
    end
  end
end
