require "rails_helper"
require "rake"

describe "rake users" do
  before do
    Rake.application.rake_require "tasks/users"
    Rake::Task.define_task(:environment)
  end

  describe "archive[email]" do
    let!(:user) { create(:user, email: "john@doe.pl") }

    before do
      Rake::Task["users:archive"].reenable
    end

    it "set archived_at field with current time" do
      Rake.application.invoke_task("users:archive[john@doe.pl]")
      expect(user.reload.archived_at).to_not be_blank
    end

    context "user with email not exists" do
      it "displays error" do
        expect { Rake.application.invoke_task("users:archive[not@exist.pl]") }
          .to raise_error("ERROR: can't find user with email: 'not@exist.pl'!")
      end
    end

    context "email not passed as a argument" do
      let(:expected_exception) do
        "ERROR: please provide an email in order to archive user!"
      end

      it "displays error" do
        expect { Rake.application.invoke_task("users:archive") }
          .to raise_error(expected_exception)
      end
    end

    context "user already archived" do
      it "does not try to archive again" do
        Rake.application.invoke_task("users:archive[john@doe.pl]")
        expect_any_instance_of(Users::Archive).to_not receive(:call)
        Rake.application.invoke_task("users:archive[john@doe.pl]")
      end
    end
  end

  describe "migrate_emails" do
    let(:user1) { build(:user, name: "John Doe", email: nil) }
    let(:user2) { build(:user, name: "Joę Dołe", email: nil) }
    let(:user3) { build(:user, name: "John Doe", email: "john@doe.pl") }
    before do
      Rake::Task["users:migrate_emails"].reenable
      user1.save(validate: false)
      user2.save(validate: false)
      user3.save(validate: false)
      allow(AppConfig).to receive(:domain) { "foo.pl" }
    end

    it "add email to all active users" do
      Rake.application.invoke_task("users:migrate_emails")
      expect(user1.reload.email).to_not be_blank
    end

    it "creates email from name" do
      Rake.application.invoke_task("users:migrate_emails")
      expect(user1.reload.email).to eq("john.doe@foo.pl")
    end

    context "user has polish chars in name" do
      it "creates email from slugified name" do
        Rake.application.invoke_task("users:migrate_emails")
        expect(user2.reload.email).to eq("joe.dole@foo.pl")
      end
    end

    context "user had already email" do
      it "does not change the email" do
        Rake.application.invoke_task("users:migrate_emails")
        expect(user3.reload.email).to eq("john@doe.pl")
      end
    end
  end
end
