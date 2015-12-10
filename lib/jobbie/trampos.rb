module Jobbie
  class Trampos < App
    def location
      opportunity['city']
    end

    def company
      opportunity['company']['name']
    end

    private

    def selectors_to_remove
    end

    def title_text
      doc.css("meta[name='title']").first.attr 'content'
    end

    def document_text
      opportunity.reject { |key| key == 'company' }.values.join ' '
    end

    def opportunity
      @opportunity ||= JSON.parse(doc.text.scan(/opportunity: (\{.*\})/).flatten[0])['opportunity']
    end
  end
end
