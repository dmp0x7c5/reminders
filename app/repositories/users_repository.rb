class UsersRepository
  def all
    User.all
  end

  def assignable
    all.where(assignable: true)
  end

  def from_auth(auth)
    User.where(
      provider: auth["provider"],
      uid: auth["uid"].to_s,
    ).first || User.create_with_omniauth(auth)
  end
end
