module Users
  class Archive
    attr_accessor :user

    def initialize(user)
      self.user = user
    end

    def call
      user.archived_at = Time.current
      user.save!
    end
  end
end
