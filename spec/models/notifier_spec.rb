require "spec_helper"

describe Notifier do
  let(:client) { double(send_message: true) }
  let(:notifier) { described_class.new(client) }

  before do
    notifier.slack_enabled = true
  end

  describe "#send_message" do
    let(:message) { "hello world" }
    let(:options) { {} }

    it "passes the message along with some default options" do
      expect(client).to receive(:chat_postMessage)
        .with(text: message,
              username: "Reminders App",
              icon_emoji: ":loudspeaker:")
      notifier.send_message message, options
    end

    it "passes additional options to client" do
      options = { foo: :bar }
      expect(client).to receive(:chat_postMessage)
        .with(text: message,
              username: "Reminders App",
              foo: :bar, icon_emoji: ":loudspeaker:")
      notifier.send_message message, options
    end
  end
end
