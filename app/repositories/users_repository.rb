class UsersRepository
  def all
    User.where(archived_at: nil).order(:name)
  end

  def find(id)
    all.find_by_id(id)
  end

  def from_auth(auth)
    User.where(
      provider: auth["provider"],
      uid: auth["uid"].to_s,
    ).first || User.create_with_omniauth(auth)
  end
end
