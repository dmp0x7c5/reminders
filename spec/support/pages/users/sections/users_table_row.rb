module Users
  class UsersTableRow < SitePrism::Section
    element :admin, ".pick-random-button"
    element :toggle_admin_button, "#toggle-admin-button"
    element :admin_label, ".label.label-primary"

    def toggle_admin_permissions!
      toggle_admin_button.click
    end
  end
end
