require "slack"

if AppConfig.slack_token.present?
  Slack.configure do |config|
    config.token = AppConfig.slack_token
  end
  Slack.auth_test
end
