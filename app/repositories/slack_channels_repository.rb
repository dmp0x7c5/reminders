class SlackChannelsRepository
  attr_accessor :slack_client

  def initialize(slack_client)
    self.slack_client = slack_client
  end

  def all
    @all ||= slack_rooms
  end

  def all_project_channels
    slack_rooms.select { |e| e["name"] =~ /^project\-/ }
  end

  def slack_rooms
    @rooms ||= slack_client.channels_list["channels"]
               .reject { |e| e["is_archived"] }
               .map { |r| SlackRoom.new(r) }
  end

  class SlackRoom < OpenStruct; end
end
