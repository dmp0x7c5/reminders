module ReminderDecorator
  class Base < Draper::Decorator
    delegate :id, :name, :interval, :valid_for_n_days,
             :persisted?
    decorates :reminder
  end
end
