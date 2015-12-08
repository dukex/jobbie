require 'open-uri'

module Jobbie
  class Vagas
    def initialize(url:, dictionary: [])
      @url = url
      @dictionary = dictionary.map { |value| Regexp.escape value }
    end

    def keywords
      doc.text.scan(regexp).flatten
    end

    def location
      address = find('address')
      address.split(' / ')[0] if address
    end

    def seniority
      find 'occupationalCategory'
    end

    private

    def find(name)
      element = doc.css("span[itemprop='#{name}']").first
      element.text if element
    end

    def regexp
      /\b(#{@dictionary.join("|")})[\b ;]/i
    end

    def doc
      @doc ||= Nokogiri(open(@url)).tap { |doc| doc.css('script, aside, .expiradaVagasSimilares').remove }
    end
  end
end
