class SlackChannelsRepository
  attr_accessor :slack_client

  def initialize(slack_client)
    self.slack_client = slack_client
  end

  def all
    @all ||= slack_rooms
  end

  def slack_rooms
    channels = slack_client.channels_list["channels"]
    channels = channels.reject { |e| e["is_archived"] }
    channels = channels.select { |e| e["name"] =~ /^project\-/ }
    channels.map { |e| e["name"].sub("project-", "") }
  end
end
