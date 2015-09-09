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
end
