module ReminderDecorator
  class Base < Draper::Decorator
    delegate :id, :name, :valid_for_n_days, :deadline_text, :notification_text,
             :persisted?
    decorates :reminder

    def remind_after_days
      if object.remind_after_days.any?
        object.remind_after_days.join(", ")
      else
        "No reminders before deadline"
      end
    end

    def number_of_overdue_project
      ProjectCheckDecorator.decorate_collection(object.project_checks).count(&:overdue?)
    end
  end
end
