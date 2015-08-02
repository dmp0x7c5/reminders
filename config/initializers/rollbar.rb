require "rollbar/rails"

Rollbar.configure do |config|
  config.access_token = AppConfig.rollbar_token
  config.enabled = false if Rails.env.test? || Rails.env.development?
end
