require 'spec_helper'

describe Jobbie::NinetynineJobs do
  describe '#location' do
    it 'returns the location' do
      VCR.use_cassette '99jobs-6648-estagio-em-direito-contratos' do
        expect(described_class.new(url: 'https://www.99jobs.com/abril/jobs/6648-estagio-em-direito-contratos').location).to eql 'São Paulo'
      end
    end
  end

  describe '#seniority' do
    it 'returns the seniority' do
      VCR.use_cassette '99jobs-6648-estagio-em-direito-contratos' do
        expect(described_class.new(url: 'https://www.99jobs.com/abril/jobs/6648-estagio-em-direito-contratos').seniority).to eql 'Estágio'
      end
    end
  end

  describe '#required_skills' do
    it 'returns the required skills' do
      VCR.use_cassette '99jobs-6727-ios-hero' do
        expect(described_class.new(url: 'https://www.99jobs.com/inevent/jobs/6727-ios-hero', dictionary: { skills: %w(Java iOS Python) }).required_skills).to include 'iOS'
      end
    end
  end

  describe '#skills' do
    it 'returns the skills' do
      VCR.use_cassette '99jobs-6663-desenvolvimento-web-sr' do
        expect(described_class.new(url: 'https://www.99jobs.com/prox-solucao-de-implantacao-de-sistemas-ltda/jobs/6663-desenvolvimento-web-sr', dictionary: { skills: %w(JavaScript Ruby Python) }).skills).to match_array %w(JavaScript)
      end
    end
  end

  describe '#focuses' do
    it 'returns the focuses' do
      VCR.use_cassette '6783-desenvolvedor-a-front-end' do
        expect(described_class.new(url: 'https://www.99jobs.com/techmob/jobs/6783-desenvolvedor-a-front-end', dictionary: { focuses: ['Front End'] }).focuses).to match_array ['Front-end', 'Front-end', 'front-end']
      end
    end
  end

  describe '#company' do
    it 'returns the company' do
      VCR.use_cassette '99jobs-6648-estagio-em-direito-contratos' do
        expect(described_class.new(url: 'https://www.99jobs.com/abril/jobs/6648-estagio-em-direito-contratos').company).to eql 'Abril'
      end
    end
  end

  describe '#jobs' do
    it 'returns the jobs' do
      VCR.use_cassette '99jobs-ruby' do
        jobs = described_class.new(url: 'https://www.99jobs.com/opportunities/search?utf8=%E2%9C%93&search[term]=ruby').jobs
        expect(jobs.size).to eql 8
        expect(jobs[0].title).to eql 'Oportunidade RubyOnRails [aceita...'
        expect(jobs[0].location).to eql 'São José dos Campos'
        expect(jobs.first.url).to eql 'https://www.99jobs.com/is/jobs/2499-oportunidade-rubyonrails-aceitamos-remoto'
        expect(jobs.last.url).to eql 'http://www.indeed.com.br/viewjob?jk=122aad586aabc0c9&qd=9D1-e_oxt8bu6zjyUTylcwq-GLP2vL_g1VE5XYfPzvkQHwIPh1fKbIAqilcWIX1ThqDH410613G5kf4UM8Xvykg31ppyphAWdifFbTa8Vqo&indpubnum=4476216539687836&atk=19ogtu9li5uqq860'
      end
    end
  end
end
