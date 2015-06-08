require "rails_helper"

describe PickCheckerService do
  let(:service) { described_class.new(latest_checker: user) }
  let(:users_repository) { UsersRepository.new }

  before do
    %w(John Jake Hank).each do |name|
      create(:user, name: name)
    end
  end

  describe "#call" do
    let(:user) { create(:user, name: "Jane") }

    it "returns user" do
      expect(service.call).to be_an_instance_of User
    end

    it "returns user different then latest checker" do
      5.times do
        expect(service.call).not_to eq user
      end
    end
  end
end
