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

  describe "#archive_user_btn" do
    let(:btn) { decorator.archive_user_btn }

    it "renders <a> tag" do
      expect(btn).to have_tag("a")
    end

    it "has post method attribute" do
      expect(btn).to have_tag("a", with: { "data-method" => "post" })
    end

    it "has proper url" do
      expect(btn).to have_tag("a", with: { "href" => "/users/1/archive" })
    end

    it "has proper confirmation message" do
      confirm = "Are you sure you want to archive #{user.name}?"
      expect(btn).to have_tag("a", with: { "data-confirm" => confirm })
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

  describe "#paused_as_string" do
    context "user is paused" do
      it "returns 'paused'" do
        user.paused = true
        expect(decorator.paused_as_string).to eq("paused")
      end
    end

    context "user is not paused" do
      it "returns 'paused'" do
        user.paused = false
        expect(decorator.paused_as_string).to eq("not paused")
      end
    end
  end
end
