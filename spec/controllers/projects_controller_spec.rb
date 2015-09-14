require "rails_helper"

describe ProjectsController do
  let(:user) { create(:admin) }

  before do
    allow(controller).to receive(:current_user) { user }
  end

  describe "update" do
    let(:project) { create(:project) }

    subject { patch :update, params }

    context "with valid params" do
      let(:expected_notice) { "Project was successfully updated." }
      let(:params) do
        { id: project.id, project: { email: "new_project@email.com" } }
      end
      it "redirect to projects index" do
        expect(subject)
          .to redirect_to(projects_path)
      end

      it "renders success notice" do
        subject
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid params" do
      let(:expected_notice) { "Project was successfully updated." }
      let(:params) do
        { id: project.id, project: { email: nil } }
      end

      it "redirect to projects index" do
        expect(subject)
          .to render_template(:edit)
      end
    end
  end
end
