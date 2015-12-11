module Jobbie
  class Vagas < App
    def seniority
      find("span[itemprop='occupationalCategory']").text
    end

    def company
      @company ||= find('title').text.scan(/\-\s(.*)\s\(/).flatten.first
    end

    private

    def to_job_params(job)
      a = job.css("a").first
      { url: path_to_url(a.attr('href')), title: a.attr('title'), location: job.css("span[itemprop='addressLocality']").first.text.split(' / ')[0], company: job.css("span[itemprop='name']").first.text.strip }
    end

    def jobs_selector
      'article.vaga'
    end

    def selectors_to_remove
      'script, aside, .expiradaVagasSimilares'
    end

    def location_selector
      "span[itemprop='address']"
    end
  end
end
