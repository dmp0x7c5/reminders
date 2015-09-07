class InMemoryRepository
  def create(record)
    id = records.keys.count + 1
    record.id ||= id
    @records[id] = record
  end

  def update(record)
    @records[id] = record
  end

  def delete(record)
    @records.delete record.id
  end

  def find(id)
    records.fetch id
  end

  def all
    records.values
  end

  def persist(record)
    if record.id.present?
      update record
    else
      create record
    end
  end

  def all=(records)
    records.each { |r| create(r) }
    all
  end

  def latest_assignment(project_check, completed: false)
    query = all.where(project_check_id: project_check.id)
    if completed
      query.where("completion_date IS NOT NULL").order("completion_date ASC")
    else
      query
    end.last
  end

  private

  def records
    @records ||= {}
  end
end
