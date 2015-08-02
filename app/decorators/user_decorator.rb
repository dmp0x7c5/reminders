class UserDecorator < Draper::Decorator
  delegate :id, :name, :admin?, :created_at

  def admin_label
    h.content_tag :span, "admin", class: "label label-primary" if admin?
  end
end
