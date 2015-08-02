require "rails_helper"

describe CheckAssignmentsRepository do
  let(:repo) { described_class.new }
  let(:project_check) { create(:project_check) }

  describe "#latest_assignment" do
    before do
      create(:check_assignment, project_check: project_check,
                                user: create(:user))
      create(:check_assignment, project_check: project_check,
                                completion_date: Time.zone.now,
                                user: create(:user))
    end

    it "returns latest check assignment" do
      latest = repo.latest_assignment(project_check)
      expect(latest.completion_date).not_to be nil
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
