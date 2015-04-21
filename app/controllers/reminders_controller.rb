class RemindersController < ApplicationController
  expose(:reminders_repository) { RemindersRepository.new }
  expose(:reminders) do
    ReminderDecorator.decorate_collection reminders_repository.all
  end
  expose(:reminder) { reminders_repository.find(params[:id]) }

  def index; end

  def show
    self.reminder = ReminderDecorator.decorate(reminder)
  end

  def new
    self.reminder = Reminder.new
  end

  def edit; end

  def create
    self.reminder = Reminder.new reminder_attrs
    if reminders_repository.create reminder
      redirect_to reminder, notice: "Reminder was successfully created."
    else
      render :new
    end
  end

  def update
    if reminders_repository.update reminder
      redirect_to reminder, notice: "Reminder was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    reminders_repository.delete reminder
    redirect_to reminders_url, notice: "Reminder was successfully destroyed."
  end

  private

  def reminder_attrs
    params.require(:reminder).permit(:name, :interval)
  end
end
