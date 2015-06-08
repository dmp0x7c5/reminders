require "rails_helper"

describe CheckAssignments::ResolveAction do
  let(:service) { described_class.new(assignment: assignment) }

  describe "#can_create?" do
    context "when assignment is nil" do
      let(:assignment) { nil }

      it "returns true" do
        expect(service.can_create?).to be true
      end
    end

    context "with completed assignment " do
      let(:assignment) { double(:assignment, completion_date: "2015-06-06") }

      it "returns true" do
        expect(service.can_create?).to be true
      end
    end

    context "with uncompleted assignment" do
      let(:assignment) { double(:assignment, completion_date: nil) }

      it "returns false" do
        expect(service.can_create?).to be false
      end
    end
  end
end
