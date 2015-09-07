require "rails_helper"

describe UsersRepository do
  let(:repo) { described_class.new }

  describe "#all" do
    before do
      2.times { create(:user) }
    end

    it "returns all users" do
      expect(repo.all.count).to eq 2
    end
  end

  describe "#from_auth" do
    let(:auth) { { provider: "google", uid: 123 } }

    context "when user exists" do
      let(:user) { create(:user, provider: "google", uid: 123) }

      it "returns user with given auth data" do
        expect(repo.from_auth(auth)).to be_an_instance_of User
      end
    end

    context "when user doesn't exist" do
      it "it creates new user and returns it" do
        expect(repo.all.count).to eq 0
        expect(repo.from_auth(auth)).to be_an_instance_of User
        expect(repo.all.count).to eq 1
      end
    end
  end

  describe "#toggle_admin" do
    context "user is admin" do
      let(:user) { create(:user, admin: true) }
      it "changes user.admin to false" do
        repo.toggle_admin(user.id)
        expect(user.reload.admin).to be_falsey
      end
    end

    context "user is not admin" do
      let(:user) { create(:user, admin: false) }
      it "changes user.admin to true" do
        repo.toggle_admin(user.id)
        expect(user.reload.admin).to be_truthy
      end
    end
  end

  describe "#toggle_paused" do
    context "user is paused" do
      let(:user) { create(:user, paused: true) }
      it "change value of paused to false" do
        repo.toggle_paused(user.id)
        expect(user.reload.paused).to be_falsy
      end
    end

    context "user is not paused" do
      let(:user) { create(:user, paused: false) }
      it "change value of paused to false" do
        repo.toggle_paused(user.id)
        expect(user.reload.paused).to be_truthy
      end
    end
  end
end
