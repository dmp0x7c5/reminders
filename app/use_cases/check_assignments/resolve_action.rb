module CheckAssignments
  class ResolveAction
    attr_reader :assignment, :assignment_creator, :assignment_completer
    private :assignment, :assignment_creator, :assignment_completer

    def initialize(data)
      @assignment = data.fetch(:assignment)
      @assignment_creator = data.fetch(:creator, nil)
      @assignment_completer = data.fetch(:completer, nil)
    end

    def resolve
      return if assignment_creator.nil? || assignment_completer.nil?
      if can_create?
        assignment_creator.call
      else
        assignment_completer.call
      end
    end

    def can_create?
      assignment.nil? || assignment.completion_date.present?
    end
  end
end
