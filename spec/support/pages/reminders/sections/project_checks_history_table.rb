  class ProjectChecksHistoryTable < SitePrism::Section
    elements :checks, "tr.single_check"

    def checks_number
      checks.count
    end
  end
