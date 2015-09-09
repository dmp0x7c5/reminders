module Users
  class Archive
    attr_accessor :user

    def initialize(user)
      self.user = user
    end

    def call
      user.archived_at = Time.zone.now
      user.save!
    end
  end
end
