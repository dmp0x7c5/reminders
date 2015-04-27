class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :project_checks, dependent: :destroy
end
