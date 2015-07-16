module CheckAssignments
  class Notify
    attr_reader :notifier
    private :notifier

    def initialize
      @notifier = Notifier.new
    end

    def notify(channel_name, message)
      return slack_disabled(message) unless notifier.slack_enabled?

      channel = prep_channel_name(channel_name)
      slack_message = slack_message(message)

      output = notifier.notify_slack(slack_message, channel: channel)
      final_notice(output, message)
    end

    private

    def slack_disabled(message)
      message +
        "We couldn't notify channel because Slack is disabled."
    end

    def prep_channel_name(channel_name)
      "##{channel_name}"
    end

    def slack_message(message)
      "Just letting know that " + message +
        "Please let them know."
    end

    def final_notice(notifier_output, message)
      if notifier_output["ok"]
        message + " We have notified project's channel."
      else
        message + " Something went wrong and we could't notify channel."
      end
    end
  end
end
