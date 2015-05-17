class ProjectDecorator < Draper::Decorator
  delegate :id, :name

  def created_at
    h.l object.created_at
  end

  def channel_name
    "##{object.channel_name}"
  end
end
