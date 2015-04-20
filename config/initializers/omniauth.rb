Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, AppConfig.omniauth_provider_key, AppConfig.omniauth_provider_secret
end
