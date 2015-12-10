module Jobbie
  class NinetynineJobs < App
    def seniority
      find('.col-md-6 p').text
    end

    private

    def company_locator
      '.col-md-3 h1.panel-title'
    end

    def location_selector
      'address'
    end
  end
end
