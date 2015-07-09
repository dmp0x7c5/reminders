  class ProjectChecksHistoryTable < SitePrism::Section
    elements :checks, "tr.single_check"

    def done_checks_number
      checks.count
    end
  end
