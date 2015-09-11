class CheckAssignmentsInMemoryRepository < InMemoryRepository
  def latest_assignment(project_check, completed: false)
    query = all.where(project_check_id: project_check.id)
    if completed
      query.where("completion_date IS NOT NULL").order("completion_date ASC")
    else
      query
    end.last
  end
end
