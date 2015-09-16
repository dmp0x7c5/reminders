require "rails_helper"

describe Projects::Archive do
  let(:service) { described_class.new(project) }
  let(:project) { create(:project) }

  describe "#call" do
    it "sets current date on archived_at field of passed project" do
      Timecop.freeze(Time.now) do
        expect { service.call }.to change { project.archived_at }
        expect(project.archived_at).to eq(Time.now)
      end
    end
  end
end
