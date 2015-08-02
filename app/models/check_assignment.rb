class CheckAssignment < ActiveRecord::Base
  belongs_to :project_check
  belongs_to :user

  validates :user, presence: true
end
