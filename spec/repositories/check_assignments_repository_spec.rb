require "rails_helper"

describe CheckAssignmentsRepository do
  let(:repo) { described_class.new }
  let(:project_check) { create(:project_check) }

  describe "#latest_assignment" do
    let!(:monday_assignment) do
      create(:check_assignment,
             project_check: project_check,
             user: create(:user),
             completion_date: 7.days.ago,
            )
    end
    let!(:wednesday_assignment) do
      create(:check_assignment,
             project_check: project_check,
             user: create(:user),
             completion_date: 5.days.ago,
            )
    end
    let!(:fresh_assignment) do
      create(:check_assignment,
             project_check: project_check,
             user: create(:user),
            )
    end

    it "returns latest check assignment" do
      expect(repo.latest_assignment(project_check)).to eq fresh_assignment
    end

    context "completed: true" do
      it "returns latest completed check assignment" do
        expect(
          repo.latest_assignment(project_check,
                                 completed: true),
        ).to eq wednesday_assignment
      end
    end
  end

  describe "#add" do
    let(:parameters) { { project_check: project_check, user: create(:user) } }

    it "creates new check_assignment" do
      expect(repo.latest_assignment(project_check)).to be nil
      repo.add(parameters)
      expect(repo.latest_assignment(project_check))
        .to be_an_instance_of CheckAssignment
    end
  end

  describe "#update" do
    let(:user) { create(:user) }
    let(:check_assignment) do
      create(:check_assignment, project_check: project_check,
                                user: create(:user))
    end

    it "updates given check assignment" do
      expect do
        repo.update(check_assignment, user_id: user.id)
      end.to change { check_assignment.user_id }.to user.id
    end
  end
end
