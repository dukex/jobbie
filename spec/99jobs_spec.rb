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
        expect(described_class.new(url: 'https://www.99jobs.com/techmob/jobs/6783-desenvolvedor-a-front-end', dictionary: { focuses: ['Front End'] }).focuses.uniq).to match_array ['Front-end']
      end
    end
  end
end
