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

  def has_checked_reviews?
    checked_reviews.any?
  end
end
