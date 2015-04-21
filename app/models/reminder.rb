class Reminder < ActiveRecord::Base
  validates :name, presence: true
end
