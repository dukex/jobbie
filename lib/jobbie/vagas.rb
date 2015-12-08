require 'open-uri'

module Jobbie
  class Vagas
    def initialize(url:, dictionary: {})
      @url = url
      @dictionary = dictionary
    end

    %w(focuses skills).each do |collection|
      define_method collection do
        scan @dictionary[collection.to_sym]
      end
    end

    def location
      address = find('address')
      address.split(' / ')[0] if address
    end

    def seniority
      find 'occupationalCategory'
    end

    private

    def scan(values)
      doc.text.scan(regexp(values.map { |value| Regexp.escape value })).flatten
    end

    def find(name)
      element = doc.css("span[itemprop='#{name}']").first
      element.text if element
    end

    def regexp(values)
      /\b(#{values.join("|")})[\b ;]/i
    end

    def doc
      @doc ||= Nokogiri(open(@url)).tap { |doc| doc.css('script, aside, .expiradaVagasSimilares').remove }
    end
  end
end
