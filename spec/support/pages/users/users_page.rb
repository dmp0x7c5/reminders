require_relative "./sections/users_table_row.rb"

module Users
  class UsersPage < SitePrism::Page
    set_url "/users"
    sections :user_rows, UsersTableRow,
             ".row .col-xs-12 table.table tbody tr"
    element :flash_notice, ".flash-message"
  end
end
