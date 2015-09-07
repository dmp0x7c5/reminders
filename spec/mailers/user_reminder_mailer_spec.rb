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
    project.stub(:decorate) { project }
    project.stub(:email) { "abc-def-team@netguru.pl" }
  end

  it "send one email" do
    expect { subject.deliver }
      .to change { deliveries.count }
      .by(1)
  end

  it "set proper subject" do
    subject.deliver
    expect(delivered_email.subject)
      .to include("waiting for you")
  end

  it "sends to assigned user" do
    subject.deliver
    expect(delivered_email.to)
      .to include(user.email)
  end

  it "sends to team email as cc" do
    subject.deliver
    expect(delivered_email.cc)
      .to include("abc-def-team@netguru.pl")
  end

  it "set proper body" do
    subject.deliver
    expect(delivered_email.body)
      .to include(reminder.name)

    expect(delivered_email.body)
      .to include(project.name)
  end
end
