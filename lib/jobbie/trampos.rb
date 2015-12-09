module Jobbie
  class Trampos < App
    def location
      opportunity['city']
    end

    private

    def title_text
      doc.css("meta[name='title']").first.attr 'content'
    end

    def document_text
      opportunity.values.join ' '
    end

    def opportunity
      @opportunity ||= JSON.parse(doc.text.scan(/opportunity: (\{.*\})/).flatten[0])['opportunity'].tap do |hash|
        hash.delete 'company'
      end
    end
  end
end
