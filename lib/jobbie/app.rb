require 'open-uri'

module Jobbie
  class App
    attr_reader :url, :title

    def initialize(url:, dictionary: {}, title: nil, location: nil)
      @url = url
      @dictionary = dictionary
      @title = title
      @location = location
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
      @location ||= begin
        element = find location_selector
        element.text.split(%r{[,\/]})[0].strip if element
      end
    end

    def company
      find(company_locator).text
    end

    def jobs
      jobs_elements.map { |job| self.class.new to_job_params(job) }
    end

    private

    def jobs_elements
      doc.css(jobs_selector)
    end

    def title_text
      doc.css(title_selector).map(&:text).join(' ')
    end

    def find(selector)
      doc.css(selector).first
    end

    def scan(values)
      document_text.gsub(%r{,|\/}, ' ').scan(regexp(values)).flatten
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
      /(?:\s(?:|\W)|^)(#{values.map { |value| Regexp.escape(value).gsub("\\ ", "[\\ \\-]") }.join("|")})(?:\s|\W\s)/i
    end

    def title_selector
      'h1'
    end

    def selectors_to_remove
      'script, aside'
    end

    def path_to_url(path)
      path.start_with?("http") ? path : build_url(path)
    end

    def build_url(path)
      uri = URI url
      "#{uri.scheme}://#{uri.host}#{path}"
    end
  end
end
