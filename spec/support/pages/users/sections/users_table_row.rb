module Users
  class UsersTableRow < SitePrism::Section
    element :admin, ".pick-random-button"
    element :toggle_admin_button, "#toggle-admin-button"
    element :admin_label, ".label.label-primary"
    element :toggle_paused_button, ".toggle-switch"

    def toggle_admin_permissions!
      toggle_admin_button.click
    end

    def paused?
      toggle_paused_button[:checked] != true
    end

    def pause!
      toggle_paused_button.set(false)
    end

    def unpause!
      toggle_paused_button.set(true)
    end
  end
end
