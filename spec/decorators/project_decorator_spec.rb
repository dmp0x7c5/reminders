require "rails_helper"

describe ProjectDecorator do
  let(:project) { OpenStruct.new(name: "abc") }
  let(:decorator) { described_class.new(project) }

  describe "#archive_button_class" do
    context "project is archived" do
      before { project.archived_at = Time.now }
      it { expect(decorator.archive_button_class).to eq("disabled") }
    end

    context "project is not archived" do
      before { project.archived_at = nil }
      it { expect(decorator.archive_button_class).to be_nil }
    end
  end
end
