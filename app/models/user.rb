class User < ActiveRecord::Base
  has_many :skills
  has_many :check_assignments

  end
end
