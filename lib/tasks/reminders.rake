namespace :reminders do
  desc "Checks all the reminders if the dates are correct"
  task check_all: :environment do
    RemindersRepository.new.all.each do |reminder|
      CheckReminderJob.perform_later reminder.id
    end
  end
end
