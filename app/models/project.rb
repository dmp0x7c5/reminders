class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :project_checks, dependent: :destroy
  has_many :reminders, through: :project_checks
end
