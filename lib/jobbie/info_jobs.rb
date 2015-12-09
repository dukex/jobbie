module Jobbie
  class InfoJobs < App
    private

    def selectors_to_remove
      '.gridSuggested.summary'
    end

    def location_selector
      '#ctl00_phMasterPage_cVacancySummary_litLocation'
    end
  end
end
