module Jobbie
  class Vagas < App
    def seniority
      find("span[itemprop='occupationalCategory']").text
    end

    private

    def selectors_to_remove
      'script, aside, .expiradaVagasSimilares'
    end

    def location_selector
      "span[itemprop='address']"
    end
  end
end
