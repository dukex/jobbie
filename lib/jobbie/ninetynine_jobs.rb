module Jobbie
  class NinetynineJobs < App
    def seniority
      find('.col-md-6 p').text
    end

    private

    def to_job_params(job)
      a = job.css('a').first
      { url: a.attr('href'), title: a.css('h1').first.text.strip, location: a.css('.mbf').first.text.scan(/Local  (.*),/).flatten[0] }
    end

    def jobs_selector
      'div.panel-opportunity'
    end

    def company_locator
      '.col-md-3 h1.panel-title'
    end

    def location_selector
      'address'
    end
  end
end
