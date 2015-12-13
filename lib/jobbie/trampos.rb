require 'json'

module Jobbie
  class Trampos < App
    def location
      @location ||= opportunity['city']
    end

    def company
      @company ||= company_from(opportunity)
    end

    private

    def selectors_to_remove
    end

    def to_job_params(job)
      { url: path_to_url("/oportunidades/#{job['id']}"), title: job['name'], location: job['city'], company: company_from(job) }
    end

    def company_from(job)
      (job['company'] || {})['name']
    end

    def jobs_elements
      opportunities
    end

    def title_selector
      'h2'
    end

    def title_text
      super.gsub(/\#\w{2} /, '')
    end

    def document_text
      opportunity.reject { |key| key == 'company' }.values.join ' '
    end

    %w(opportunities opportunity).each do |name|
      define_method name do
        instance_variable_get("@#{name}") || instance_variable_set("@#{name}", parse(name))
      end
    end

    def parse(name)
      JSON.parse(doc.text.scan(/#{name}: (\{.*\})/).flatten[0])[name]
    end
  end
end
