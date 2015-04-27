class Notifier
  attr_accessor :client

  def initialize(client = Slack.client)
    self.client = client
  end

  def send_message(message, options = {})
    options.merge!(
      text: message,
      username: "Reminders app",
    )
    client.chat_postMessage options
  end
end
