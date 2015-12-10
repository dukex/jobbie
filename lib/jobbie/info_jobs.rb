module Jobbie
  class InfoJobs < App
    private

    def to_job_params(job)
      a = job.css('.vaga a').first
      { url: a.attr('href'), title: a.text.strip, location: job.css("span[itemprop='addressLocality']").first.text.strip }
    end

    def jobs_elements
      doc.css('#ctl00_phMasterPage_cGrid_divGrid ul.unstyled.left')
    end

    def company_locator
      '#ctl00_phMasterPage_cVacancySummary_litCompany'
    end

    def selectors_to_remove
      '.gridSuggested.summary'
    end

    def location_selector
      '#ctl00_phMasterPage_cVacancySummary_litLocation'
    end
  end
end
