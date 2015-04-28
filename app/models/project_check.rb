class ProjectCheck < ActiveRecord::Base
  belongs_to :project
  belongs_to :reminder
  belongs_to :last_check_user, class: User
end
