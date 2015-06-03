class AssignmentsService
  attr_reader :assignment, :checker, :completed,
              :assignments_repository, :project_check_id
  private :assignment, :checker, :completed,
          :assignments_repository, :project_check_id

  def initialize(args)
    @assignment = args.fetch(:assignment, nil)
    @checker = args.fetch(:checker)
    @completed = args.fetch(:completed)
    @project_check_id = args.fetch(:project_check_id)
    @assignments_repository = args.fetch(:assignments)
  end

  def call
    if completed
      create_completed_or_update
    else
      create_uncompleted
    end
  end

  private

  def create_completed_or_update
    if assignment.nil? || assignment.completion_date.present?
      create_completed
    else
      update(assignment)
    end
  end

  def create_completed
    parameters = {
      user_id: checker.id,
      project_check_id: project_check_id,
      completion_date: Time.now,
    }
    create_assignment(parameters)
  end

  def create_uncompleted
    parameters = {
      user_id: checker.id,
      project_check_id: project_check_id,
    }
    create_assignment(parameters)
  end

  def create_assignment(parameters)
    assignments_repository.add(parameters)
  end

  def update(assignment)
    attributes = { completion_date: Time.now, user_id: checker.id }
    assignments_repository.update(
      assignment,
      attributes,
    )
  end
end
