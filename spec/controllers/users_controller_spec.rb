require "rails_helper"

describe UsersController do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:bye_user) { create(:user) }

  before do
    allow(controller).to receive(:current_user) { current_user }
  end

  describe "archive" do
    let(:params) { { id: bye_user.id } }
    subject { post :archive, params }

    context "when admin" do
      let(:current_user) { admin }

      it "calls Archive service" do
        archive_service_instance = double
        allow(Users::Archive).to receive(:new)
          .with(bye_user)
          .and_return(archive_service_instance)
        expect(archive_service_instance).to receive(:call).once
        subject
      end

      it "redirects to users index" do
        expect(subject).to redirect_to(users_path)
      end

      it "renders notice" do
        subject
        expect(flash[:notice]).to have_text("User has been archived.")
      end
    end

    context "when regular user" do
      let(:current_user) { user }

      it "does not call Archive service" do
        expect_any_instance_of(Users::Archive).not_to receive(:call)
        subject
      end

      it "redirects to root path" do
        expect(subject).to redirect_to(root_path)
      end

      it "renders notice" do
        subject
        expect(flash[:alert]).to have_text("You need to be admin to access to this page.")
      end
    end
  end
end
