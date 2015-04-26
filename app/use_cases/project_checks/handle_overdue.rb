module ProjectChecks
  class HandleOverdue
    attr_accessor :check, :days_diff, :notifier

    def initialize(check, days_diff, notifier = nil)
      self.check = check
      self.days_diff = days_diff
      self.notifier = notifier || Notifier.new
    end

    def call
      notify!
    end

    private

    def notify!
      notifier.send_message notification
    end

    def reminder
      check.reminder
    end

    def project
      check.project
    end

    def notification
      "It looks like last #{reminder.name} in #{project.name} was done \
      *#{days_diff} days ago* - it should be done every \
      #{reminder.valid_for_n_days} days or so. \n\n"
    end
  end
end
