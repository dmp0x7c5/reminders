module Users
  class SyncWithOmniauth
    attr_accessor :auth, :user

    def initialize(user, auth)
      self.user = user
      self.auth = auth
    end

    def call
      return if auth["info"]["email"] == user.email
      user.update_column(:email, auth["info"]["email"])
    end
  end
end
