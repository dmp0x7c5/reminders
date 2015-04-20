class UsersRepository
  def from_auth(_auth)
    User.where(
      provider: auth["provider"],
      uid: auth["uid"].to_s,
    ).first || User.create_with_omniauth(auth)
  end
end
