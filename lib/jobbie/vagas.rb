require 'open-uri'

module Jobbie
  class Vagas < App
    def seniority
      find("span[itemprop='occupationalCategory']").text
    end

    private

    def location_selector
      "span[itemprop='address']"
    end
  end
end
