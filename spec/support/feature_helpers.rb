module FeatureHelpers
  def log_in
    visit "auth/google_oauth2"
  end
end
