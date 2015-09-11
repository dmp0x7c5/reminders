require "rails_helper"

describe ProjectNotificationMailer do
  let(:project) { double(name: "abc def") }

  let(:reminder) { double(name: "senior review") }
  let(:project_check) { double(project: project, reminder: reminder) }
  let(:notification) { "notification body" }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:delivered_email) { deliveries.last }

  subject do
    described_class.check_reminder(notification, project_check)
  end

  before do
    allow(project).to receive(:decorate) { project }
    allow(project)
      .to receive(:email) { "foo@email.com" }
  end

  it "send one email" do
    expect { subject.deliver_now }
      .to change { deliveries.count }
      .by(1)
  end

  it "set proper subject" do
    subject.deliver_now
    expect(delivered_email.subject)
      .to include("next senior review in abc def")
  end

  it "sends to project email" do
    subject.deliver_now
    expect(delivered_email.to)
      .to include(project.email)
  end

  it "set proper body" do
    subject.deliver_now
    expect(delivered_email.body)
      .to eq(notification)
  end
end
