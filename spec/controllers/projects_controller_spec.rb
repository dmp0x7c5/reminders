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
        {
          id: project.id,
          project: { email: "new_project@email.com", channel_name: "name" },
        }
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
      let(:params) do
        { id: project.id, project: { email: nil } }
      end

      it "redirect to projects edit" do
        expect(subject)
          .to render_template(:edit)
      end

      it "not change project" do
        expect { subject }
          .to_not change { project }
      end

      context "without channel_name" do
        let(:params) do
          {
            id: project.id,
            project: { email: "not@blank.com", channel_name: nil },
          }
        end

        it "redirect to projects edit" do
          expect(subject)
            .to render_template(:edit)
        end

        it "not change project" do
          expect { subject }
            .to_not change { project }
        end
      end
    end
  end

  describe "archive" do
    let(:params) { { id: project.id } }
    let(:project) { create(:project) }
    subject { post :archive, params }

    it "calls Archive service" do
      expect_any_instance_of(Projects::Archive).to receive(:call)
      subject
    end

    it "redirects to projects index" do
      expect(subject).to redirect_to(projects_path)
    end

    it "renders notice" do
      subject
      expect(flash[:notice]).to have_text("Project has been archived.")
    end
  end
end
