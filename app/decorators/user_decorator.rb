class UserDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers

  delegate :id, :name, :admin?, :created_at, :paused

  def admin_label
    h.content_tag :span, "admin", class: "label label-primary" if admin?
  end

  def toggle_admin_btn
    h.link_to "Toggle admin",
              toggle_admin_user_path(id: id),
              method: :post,
              class: "btn btn-primary",
              id: "toggle-admin-button"
  end

  def archive_user_btn
    h.link_to "Archive",
              archive_user_path(id: id),
              class: "btn btn-danger",
              data: { confirm: "Are you sure you want to archive #{name}?" },
              id: "archive-user-button",
              method: :post
  end

  def row_class
    return unless paused
    "active"
  end

  def paused_as_string
    (paused) ? "paused" : "not paused"
  end
end
