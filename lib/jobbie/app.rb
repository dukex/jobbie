require 'open-uri'

module Jobbie
  class App
    def initialize(url:, dictionary: {})
      @url = url
      @dictionary = dictionary
    end

    def seniority
      scan(%w(Junior Júnior Senior Sênior Pleno)).first
    end

    def required_skills
      title_text.scan(regexp(@dictionary[:skills])).flatten
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

    def company
      find(company_locator).text
    end

    private

    def title_text
      doc.css(title_selector).map(&:text).join(' ')
    end

    def find(selector)
      doc.css(selector).first
    end

    def scan(values)
      document_text.scan(regexp(values)).flatten
    end

    def document_text
      doc.text
    end

    def doc
      @doc ||= Nokogiri(open(@url).read, nil, 'utf-8').tap do |doc| 
        doc.css(selectors_to_remove).remove if selectors_to_remove
      end
    end

    def regexp(values)
      /\b(#{values.map { |value| Regexp.escape(value).gsub("\\ ", "[\\ \\-]") }.join("|")})[\b\s;,\n\)]/i
    end

    def title_selector
      'h1'
    end

    def selectors_to_remove
    end
  end
end
