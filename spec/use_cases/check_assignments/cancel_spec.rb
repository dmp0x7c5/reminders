require "rails_helper"

describe CheckAssignments::Cancel do
  let(:service) do
    described_class.new(
      check_assignment,
      check_assignments_repo: assignments_repo,
    )
  end
  let(:project_check) do
    create(:project_check,
           reminder: reminder,
           project: project,
          )
  end
  let(:check_assignment) do
    create(:check_assignment, id: 1, user: user, project_check: project_check)
  end
  let(:assignments_repo) do
    repo = InMemoryRepository.new
    repo.all = [check_assignment]
    repo
  end
  let(:reminder) { create(:reminder, name: "sample review") }
  let(:project) { create(:project, name: "test", channel_name: "test") }
  let(:user) { create(:user, name: "John Doe", email: "john@doe.pl") }

  describe "#call" do
    it "deletes the check assignment" do
      expect { service.call }
        .to change { assignments_repo.all.count }
        .by(-1)
    end

    it "returns notice text" do
      expect(service.call).to be_an_instance_of String
    end

    context "sending email" do
      before do
        ActionMailer::Base.deliveries = []
      end

      it "sends one email" do
        expect { service.call }
          .to change { ActionMailer::Base.deliveries.count }
          .by(1)
      end

      it "sends email to assigned user" do
        service.call
        expect(ActionMailer::Base.deliveries.last.to)
          .to include "john@doe.pl"
      end
    end
  end
end
