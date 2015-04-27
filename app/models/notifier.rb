class Notifier
  attr_accessor :client, :slack_enabled

  def initialize(client = Slack.client)
    self.client = client
  end

  def send_message(message, options = {})
    notify_slack(message, options) if slack_enabled?
  end

  def notify_slack(message, options)
    options.merge!(
      text: message,
      username: "Reminders app",
    )
    client.chat_postMessage options
  end

  def slack_enabled?
    @slack_enabled || AppConfig.slack_enabled
  end
end
