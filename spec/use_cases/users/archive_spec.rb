require "rails_helper"

describe Users::Archive do
  let(:service) { described_class.new(user) }
  let(:user) { create(:user) }

  describe "#call" do
    it "set current date on archived_at field of passed user" do
      Timecop.freeze(Time.current) do
        expect { service.call }.to change { user.archived_at }
        expect(user.archived_at).to eq(Time.current)
      end
    end
  end
end
