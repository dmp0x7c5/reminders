require "rails_helper"

describe ProjectDecorator do
  let(:project) { OpenStruct.new(name: "abc") }
  let(:decorator) { described_class.new(project) }

  describe "#email" do
    context "name has spaces" do
      it "replace spaces with dashes" do
        project.name = "abc def"
        expect(decorator.email).to include("abc-def")
        expect(decorator.email).to_not include("abc def")
      end
    end

    it "uses data from config as domain part" do
      expect(decorator.email).to match(/^.*@(#{AppConfig.email_domain})$/)
    end
  end
end
