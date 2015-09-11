# Load the Rails application.
require File.expand_path("../application", __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: AppConfig.sendgrid_user_name,
  password: AppConfig.sendgrid_password,
  domain: AppConfig.domain,
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true,
}
