module ProjectChecks
  class HandleNotificationDay < HandleOverdue
    def notification
      "It looks like last #{reminder.name} in #{project.name} was done \
      *#{days_diff} days ago*"
    end
  end
end
