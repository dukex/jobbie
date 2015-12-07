require 'open-uri'

module Jobbie
  class Vagas
    def initialize(url:, dictionary: [])
      @url = url
      @dictionary = dictionary
    end

    def keywords
      doc.text.scan(regexp).flatten
    end

    def location
      find('address').split(' / ')[0]
    end

    def seniority
      find 'occupationalCategory'
    end

    private

    def find(name)
      doc.css("span[itemprop='#{name}']").first.text
    end

    def regexp
      /\b(#{@dictionary.join("|")})\b/i
    end

    def doc
      @doc ||= Nokogiri(open(@url)).tap { |doc| doc.css('script, aside, .expiradaVagasSimilares').remove }
    end
  end
end
