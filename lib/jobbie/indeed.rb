module Jobbie
  class Indeed < App
    def selectors_to_remove
      '.recJobs'
    end

    def location_selector
      'span.location'
    end
  end
end
