module Jobbie
  class Trampos < App
    def location
      doc.text.scan(/"city":"([[:alpha:]\s]*)"/).flatten[0]
    end
  end
end
