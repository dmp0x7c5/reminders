module Users
  class CreateWithOmniauth
    attr_accessor :auth, :users_repository

    def initialize(auth:, users_repository: UsersRepository.new)
      self.auth = auth
      self.users_repository = users_repository
    end

    def call
      users_repository.add(prepare_attrs)
    end

    private

    def prepare_attrs
      {
        provider: auth["provider"],
        uid: auth["uid"],
        name: auth["info"]["name"],
        email: auth["info"]["email"],
      }
    end
  end
end
