class RemindersRepository
  def all
    Reminder.all
  end

  def create(entity)
    persist entity
  end

  def update(entity)
    persist entity
  end

  def persist(entity)
    entity.save
  end

  def delete(entity)
    entity.destroy
  end

  delegate :find, to: :all
end
