require 'open-uri'

module Jobbie
  class App
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
      element = find location_selector
      element.text.split(/[,\/]/)[0].strip if element
    end

    private

    def find(selector)
      doc.css(selector).first
    end

    def scan(values)
      doc.text.scan(regexp(values)).flatten
    end

    def doc
      @doc ||= Nokogiri(open(@url)).tap { |doc| doc.css('script, aside, .expiradaVagasSimilares').remove }
    end

    def regexp(values)
      /\b(#{values.map { |value| Regexp.escape(value).gsub("\\ ", "[\\ \\-]") }.join("|")})[\b ;,\)]/i
    end
  end
end
