module ReminderDecorator
  class Base < Draper::Decorator
    delegate :id, :name, :valid_for_n_days,
             :persisted?
    decorates :reminder

    def remind_after_days
      if object.remind_after_days.any?
        object.remind_after_days.join(", ")
      else
        "No reminders before deadline"
      end
    end
  end
end
