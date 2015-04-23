class ProjectChecksRepository
  def all
    ProjectCheck.all
  end

  def for_reminder(reminder)
    all.includes(:project, :reminder).where(reminder_id: reminder.id)
  end

  def find(id)
    all.find_by_id id
  end
end
