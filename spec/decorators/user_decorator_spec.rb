require "rails_helper"

describe UserDecorator do
  let(:user) { OpenStruct.new(id: 1, admin: true) }
  let(:decorator) { described_class.new(user) }

  describe "#toggle_admin_btn" do
    let(:btn) { decorator.toggle_admin_btn }

    it "renders <a> tag" do
      expect(btn).to have_tag("a")
    end

    it "has post method attribute" do
      expect(btn).to have_tag("a", with: { "data-method" => "post" })
    end

    it "has proper url" do
      expect(btn).to have_tag("a", with: { "href" => "/users/1/toggle_admin" })
    end
  end

  describe "#row_class" do
    let(:btn) { decorator.toggle_admin_btn }

    context "user is paused" do
      it "returns class active" do
        user.paused = true
        expect(decorator.row_class).to eq("active")
      end
    end

    context "user is not paused" do
      it "returns nil" do
        user.paused = false
        expect(decorator.row_class).to be_nil
      end
    end
  end
end
