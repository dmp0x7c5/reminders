namespace :reminders do
  desc "Checks all the reminders if the dates are correct"
  task check_all: :environment do
    ActiveRecord::Base.connection_pool.with_connection do
      RemindersRepository.new.all.each do |reminder|
        CheckReminderJob.new.perform reminder.id
      end
    end
  end
end
