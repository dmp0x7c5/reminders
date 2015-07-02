module FeatureHelpers
  def log_in(user)
    OmniAuth.config.mock_auth[:google_oauth2] =
      OmniAuth::AuthHash.new(
        provider: user.provider,
        uid: user.uid,
      )
    visit "auth/google_oauth2"
  end
end
