module Projects
  class ProjectTableRow < SitePrism::Section
    element :toggle_state_button, ".toggle-switch"

    def disabled?
      toggle_state_button[:checked] != true
    end

    def disable
      toggle_state_button.click
    end
  end
end
