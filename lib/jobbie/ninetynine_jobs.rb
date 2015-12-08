module Jobbie
  class NinetynineJobs < App
    def seniority
      find(".col-md-6 p").text
    end

    private

    def location_selector
      'address'
    end
  end
end
