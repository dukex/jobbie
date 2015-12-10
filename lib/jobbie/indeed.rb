module Jobbie
  class Indeed < App
    private

    def to_job_params(job)
      a = job.css('a').first
      { url: path_to_url(a.attr('href')), title: a.text, location: job.css('.location').first.text.split(',')[0] }
    end

    def jobs_selector
      'div.result'
    end

    def company_locator
      'span.company'
    end

    def selectors_to_remove
      '.recJobs'
    end

    def location_selector
      'span.location'
    end

    def title_selector
      '.jobtitle font'
    end
  end
end
