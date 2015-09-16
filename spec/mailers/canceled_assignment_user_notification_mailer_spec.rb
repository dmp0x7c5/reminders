require "rails_helper"

describe CanceledAssignmentUserNotificationMailer do
  let(:user) { double(email: "john@doe.pl", name: "John Doe") }
  let(:project) { double(name: "abc def") }
  let(:reminder) { double(name: "senior review") }
  let(:project_check) { double(project: project, reminder: reminder) }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:delivered_email) { deliveries.last }
  subject { described_class.canceled_assignment(user, project_check) }

  it "sends one email" do
    expect { subject.deliver_now }
      .to change { deliveries.count }
      .by(1)
  end

  it "sets proper subject" do
    subject.deliver_now
    expect(delivered_email.subject)
      .to include("has been canceled")
  end

  it "sends to assigned user" do
    subject.deliver_now
    expect(delivered_email.to)
      .to include(user.email)
  end

  it "sets proper body" do
    subject.deliver_now
    expect(delivered_email.body)
      .to include(reminder.name)

    expect(delivered_email.body)
      .to include(project.name)
  end
end
