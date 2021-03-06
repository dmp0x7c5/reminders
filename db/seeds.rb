projects = ["Reminders", "Review", "Profile", "Access", "People"]
reminders = [{name: "Leaders review", remind_after_days: [5, 10, 15, 20, 25],
              deadline_text: "Last *{{reminder_name}}* for _{{ project_name }}_ was done *{{ days_ago }}* .",
              notification_text: "This is notification for project _{{project_name}}."
             },
             {name: "Seniors review", remind_after_days: [10, 20],
              deadline_text: "Last *{{reminder_name}}* for _{{ project_name }}_ was done *{{ days_ago }}* .",
              notification_text: "This is notification for project _{{project_name}}.",
              valid_for_n_days: 25
             },
             {name: "Pivotal review", remind_after_days: [4, 8, 16, 20, 24, 28],
              deadline_text: "Last *{{reminder_name}}* for _{{ project_name }}_ was done *{{ days_ago }}* .",
              notification_text: "This is notification for project _{{project_name}}."
             },
             {name: "Sample reminder", remind_after_days:[5, 10, 15, 20],
              deadline_text: "Last *{{reminder_name}}* for _{{ project_name }}_ was done *{{ days_ago }}* .",
              notification_text: "This is notification for project _{{project_name}}.",
              valid_for_n_days: 25
             },
            ]

users = ["John Smith", "Jane Doe", "Charles Adams", "Lisa Morris"]

#create projects
projects.each do |project_name|
  Project.find_or_create_by(name: project_name)
end

#create reminders
CheckAssignment.delete_all
ProjectCheck.delete_all
Reminder.delete_all
reminders.each do |reminder|
  Reminder.create(name: reminder[:name],
                  valid_for_n_days: reminder[:valid_for_n_days] || 30,
                  remind_after_days: reminder[:remind_after_days],
                  deadline_text: reminder[:deadline_text],
                  notification_text: reminder[:notification_text]
                 )
end

#create users
User.delete_all
users.each do |user_name|
  User.create(name: user_name, provider: "google_oauth2", uid: Faker::Number.number(21).to_i)
end

#create project check
ProjectCheck.delete_all
project_ids = Project.ids
reminders_ids = Reminder.ids

project_ids.each_with_object(reminders_ids) do |project, reminders|
  reminders.each do |reminder|
    ProjectCheck.create(project_id: project, reminder_id: reminder)
  end
end
