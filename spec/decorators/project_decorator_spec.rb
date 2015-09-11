require "rails_helper"

describe ProjectDecorator do
  let(:project) { OpenStruct.new(name: "abc") }
  let(:decorator) { described_class.new(project) }
end
