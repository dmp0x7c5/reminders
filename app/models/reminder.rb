class Reminder < ActiveRecord::Base
  validates :name, presence: true
  has_many :project_checks
  has_many :projects, through: :project_checks
end
