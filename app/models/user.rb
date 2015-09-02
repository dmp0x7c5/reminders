class User < ActiveRecord::Base
  has_many :skills
  has_many :check_assignments

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"] || "" if auth["info"]
      user.email = auth["info"]["email"]
    end
  end
end
