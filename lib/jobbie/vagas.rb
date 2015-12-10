module Jobbie
  class Vagas < App
    def seniority
      find("span[itemprop='occupationalCategory']").text
    end

    def company
      find('title').text.scan(/\-\s(.*)\s\(/).flatten.first
    end

    private

    def to_job_params(job)
      { url: path_to_url(job.attr('href')), title: job.attr('title'), location: job.css("span[itemprop='addressLocality']").first.text.split(' / ')[0] }
    end

    def jobs_selector
      '.link-detalhes-vaga'
    end

    def selectors_to_remove
      'script, aside, .expiradaVagasSimilares'
    end

    def location_selector
      "span[itemprop='address']"
    end
  end
end
