require "rails_helper"

describe CheckAssignmentDecorator do
  let(:check_assignment) { OpenStruct.new }
  let(:decorator) { described_class.new(check_assignment) }

  describe "#assigned_days_ago" do
    context "assigned today" do
      it "returns 0" do
        check_assignment.created_at = 0.days.ago
        expect(decorator.assigned_days_ago).to eq(0)
      end
    end

    context "assigned yesterday" do
      it "returns 1" do
        check_assignment.created_at = 1.days.ago
        expect(decorator.assigned_days_ago).to eq(1)
      end
    end

    context "assigned 5 days ago" do
      it "returns 5" do
        check_assignment.created_at = 5.days.ago
        expect(decorator.assigned_days_ago).to eq(5)
      end
    end
  end

  describe "#assigned_days_ago_as_string" do
    context "assigned today" do
      it "returns today" do
        check_assignment.created_at = 0.days.ago
        expect(decorator.assigned_days_ago_as_string).to eq("today")
      end
    end

    context "assigned yesterday" do
      it "returns 1 day ago" do
        check_assignment.created_at = 1.days.ago
        expect(decorator.assigned_days_ago_as_string).to eq("1 day ago")
      end
    end

    context "assigned 5 days ago" do
      it "returns 5 days ago" do
        check_assignment.created_at = 5.days.ago
        expect(decorator.assigned_days_ago_as_string).to eq("5 days ago")
      end
    end
  end
end
