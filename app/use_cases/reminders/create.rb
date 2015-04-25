module Reminders
  class Create
    attr_accessor :attrs, :reminders_repository

    def initialize(attrs, reminders_repository = RemindersRepository.new)
      self.attrs = attrs
      self.reminders_repository = reminders_repository
    end

    def call
      self.attrs = format_remind_after_days attrs
      reminder = Reminder.new attrs
      if reminder.valid?
        reminders_repository.create(reminder)
        Response::Success.new data: reminder
      else
        Response::Error.new data: reminder
      end
    end

    private

    def format_remind_after_days(reminder_attrs)
      days = reminder_attrs[:remind_after_days] || ""
      days = days.split(",").map(&:strip).map(&:to_i) - [0]
      reminder_attrs[:remind_after_days] = days
      reminder_attrs
    end
  end
end
