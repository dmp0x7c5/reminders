require "rails_helper"

describe UserReminderMailer do
  let(:user) { double(email: "john@doe.pl") }
  let(:project) { double(name: "abc def") }
  let(:reminder) { double(name: "senior review") }
  let(:project_check) { double(project: project, reminder: reminder) }
  let(:days_diff) { 4 }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:delivered_email) { deliveries.last }
  subject do
    described_class.check_assignment_remind(user, project_check, days_diff)
  end

  before do
    deliveries = []
    allow(project).to receive(:decorate) { project }
    allow(project)
      .to receive(:email) { "abc-def#{AppConfig.project_email_ending}" }
  end

  it "send one email" do
    expect { subject.deliver_now }
      .to change { deliveries.count }
      .by(1)
  end

  it "set proper subject" do
    subject.deliver_now
    expect(delivered_email.subject)
      .to include("waiting for you")
  end

  it "sends to assigned user" do
    subject.deliver_now
    expect(delivered_email.to)
      .to include(user.email)
  end

  it "sends to team email as cc" do
    subject.deliver_now
    expect(delivered_email.cc)
      .to include("abc-def#{AppConfig.project_email_ending}")
  end

  it "set proper body" do
    subject.deliver_now
    expect(delivered_email.body)
      .to include(reminder.name)

    expect(delivered_email.body)
      .to include(project.name)
  end
end
