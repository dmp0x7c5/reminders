require_relative "sections/pick_person_user"

module Reminders
  class PickPersonPage < SitePrism::Page
    set_url "/project_checks{/project_check_id}/pick_person"
    sections :users, PickPersonUser,
             ".row .col-xs-12 table.table tbody tr"
  end
end
