class ProjectsRepository
  def all
    Project.all
  end

  def persist(entity)
    entity.save
  end

  def for_reminder(reminder)
    reminder.projects
  end

  delegate :find_by_name, to: :all
end
