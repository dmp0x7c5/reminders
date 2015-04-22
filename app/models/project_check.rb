class ProjectCheck < ActiveRecord::Base
  belongs_to :project
  belongs_to :reminder
end
