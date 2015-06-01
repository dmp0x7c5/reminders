class ProjectCheck < ActiveRecord::Base
  belongs_to :project
  belongs_to :reminder
  belongs_to :last_check_user, class: User

  scope :for_reminder, lambda  { |reminder_id|
    where(reminder_id: reminder_id)
      .order(created_at: :desc)
  }
end
