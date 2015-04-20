def google_scope
  [
    "userinfo.email",
    "userinfo.profile",
    "https://www.googleapis.com/auth/drive",
    "https://spreadsheets.google.com/feeds/",
  ].join(" ")
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           AppConfig.omniauth_provider_key,
           AppConfig.omniauth_provider_secret,
           scope: google_scope
end
