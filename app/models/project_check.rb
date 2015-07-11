class ProjectCheck < ActiveRecord::Base
  belongs_to :project
  belongs_to :reminder
  belongs_to :last_check_user, class_name: "User"

  has_many :check_assignments, -> { order created_at: :desc },
           dependent: :destroy
end
