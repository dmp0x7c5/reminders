require "rails_helper"

describe CheckAssignmentsRepository do
  let(:repo) { described_class.new }
  let(:project_check) { create(:project_check) }

  describe "#latest_assignment" do
    before do
      create(:check_assignment, project_check: project_check)
      create(:check_assignment, project_check: project_check,
                                completion_date: Time.zone.now)
    end

    it "returns latest check assignment" do
      latest = repo.latest_assignment(project_check)
      expect(latest.completion_date).not_to be nil
    end
  end

  describe "#add" do
    let(:parameters) { { project_check: project_check } }

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
      create(:check_assignment, project_check: project_check)
    end

    it "updates given check assignment" do
      expect(check_assignment.user_id).to be nil
      repo.update(check_assignment, user_id: user.id)
      expect(check_assignment.user_id).to eq user.id
    end
  end
end
