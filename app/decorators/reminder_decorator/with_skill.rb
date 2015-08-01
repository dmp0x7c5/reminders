module ReminderDecorator
  class WithSkill < Base
    decorates :reminder
    delegate :to_key, :errors

    def css_item_class
      css_class = if skill_active?
                    "list-group-item-success"
                  else
                    "list-group-item-danger"
                  end
      "list-group-item #{css_class}"
    end

    def skill_active?
      context.fetch(:user_skills).map(&:reminder_id).include?(reminder.id)
    end
  end
end
