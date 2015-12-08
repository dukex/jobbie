require 'open-uri'

module Jobbie
  class InfoJobs < App
    def seniority
      scan(%w(Junior Senior Pleno)).first
    end

    private

    def location_selector
      '#ctl00_phMasterPage_cVacancySummary_litLocation'
    end
  end
end
