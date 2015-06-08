module CheckAssignments
  class ResolveAction
    attr_reader :assignment

    def initialize(args)
      @assignment = args.fetch(:assignment)
    end

    def can_create?
      assignment.nil? || assignment.completion_date.present?
    end
  end
end
