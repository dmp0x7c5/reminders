module Reminders
  class Delete < Create
    attr_accessor :reminder, :reminders_repo

    def initialize(reminder, reminders_repo = RemindersRepository.new)
      self.reminder = reminder
      self.reminders_repo = reminders_repo
    end

    def call
      reminders_repo.delete reminder
    end
  end
end
