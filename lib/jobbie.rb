require 'nokogiri'
require 'jobbie/version'
require 'jobbie/app'
require 'jobbie/info_jobs'
require 'jobbie/ninetynine_jobs'
require 'jobbie/vagas'

module Jobbie
  class Factory
    def self.init(params)
      class_for(params[:url]).new params
    end

    def self.class_for(url)
      { "www.vagas.com.br" => Vagas,
        "www.infojobs.com.br" => InfoJobs,
        "www.99jobs.com" => NinetynineJobs
      }[URI.parse(url).host]
    end
  end
end
