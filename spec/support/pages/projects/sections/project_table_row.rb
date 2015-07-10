module Projects
  class ProjectTableRow < SitePrism::Section
    element :toggle_state_button, "td[6] a"

    def disabled?
      toggle_state_button[:class] == "btn btn-success"
    end

    def disable
      toggle_state_button.click
    end
  end
end
