module Jobbie
  class Trampos < App
    def location
      doc.text.scan(/"city":"([[:alpha:]\s]*)"/).flatten[0]
    end

    def title_text
      doc.css("meta[name='title']").first.attr 'content'
    end
  end
end
