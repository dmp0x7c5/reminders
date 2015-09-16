require "rails_helper"

describe Project do
  describe "ActiveModel validations" do
    it { is_expected.to validate_presence_of(:email) }
  end
end
