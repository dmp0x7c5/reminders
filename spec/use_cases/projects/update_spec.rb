require "rails_helper"

describe Projects::Update do
  let(:project) { create(:project, email: "project@sample.com") }
  let(:service) do
    described_class
      .new(project: project, attrs: attrs)
  end

  describe "#call" do
    context "it has valid attrs" do
      let(:attrs) { { email: "john@doe.com" } }
      it "returns successfull response" do
        expect(service.call).to be_kind_of(Response::Success)
      end

      it "changes project's attrs" do
        service.call
        expect(project.reload.email).to eq(attrs[:email])
      end
    end

    context "it has invalid attrs" do
      let(:attrs) { { email: nil } }

      it "returns error response" do
        expect(service.call).to be_kind_of(Response::Error)
      end

      it "not change project's attrs" do
        service.call
        expect(project.reload.email).to_not eq(attrs[:email])
      end
    end
  end
end
