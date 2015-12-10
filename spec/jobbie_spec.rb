require 'spec_helper'

describe Jobbie do
  it 'has a version number' do
    expect(Jobbie::VERSION).not_to be nil
  end
end

describe Jobbie::Factory do
  describe '.init' do
    { 'http://www.vagas.com.br/vagas/v1259656/tecnico-seguros-ramos-elementares' => Jobbie::Vagas,
      'http://www.infojobs.com.br/vaga-de-programacao-php-em-santa-catarina__4795320.aspx' => Jobbie::InfoJobs,
      'https://www.99jobs.com/abril/jobs/6645-estagio-em-comunicacao' => Jobbie::NinetynineJobs,
      'http://www.indeed.com.br/empregos?q=GeekHunter&l=Florian%C3%B3polis%2C+SC&from=vj' => Jobbie::Indeed,
      'http://trampos.co/oportunidades/123967' => Jobbie::Trampos
    }.each do |url, app_class|
      it "inits #{app_class} for the URL #{url}" do
        expect(described_class.init(url: url).class).to eql app_class
      end
    end
  end
end
