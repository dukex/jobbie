require 'spec_helper'

describe Jobbie::Vagas do
  describe '#location' do
    it 'returns the location' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr').location).to eql 'São Paulo'
      end
    end

    it 'returns nil when the job doesnt exist' do
      VCR.use_cassette 'vagas-aprendiz-assistente-administrativo-morumbi' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1260381/aprendiz-assistente-administrativo-morumbi').location).to be_nil
      end
    end
  end

  describe '#seniority' do
    it 'returns the seniority' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr').seniority).to eql 'Sênior'
      end
    end
  end

  describe '#required_skills' do
    it 'returns the required skills' do
      VCR.use_cassette 'vagas-desenvolvedor-de-solucoes-fantasticas-em-ruby-sp' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1190070/desenvolvedor-de-solucoes-fantasticas-em-ruby-sp', dictionary: { skills: %w(Java Ruby Python) }).required_skills).to match_array %w(Ruby)
      end
    end
  end

  describe '#skills' do
    it 'returns the skills' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr', dictionary: { skills: %w(Java Ruby Python) }).skills).to match_array %w(JAVA)
      end
    end

    it 'doesnt return skills from another jobs from the company' do
      VCR.use_cassette 'vagas-analista-de-sistemas-sharepoint-pleno' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1253580/analista-de-sistemas-sharepoint-pleno', dictionary: { skills: ['DotNet'] }).skills).to be_empty
      end
    end

    it 'returns C# as an skill' do
      VCR.use_cassette 'vagas-analista-de-sistemas' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1261175/analista-de-sistemas', dictionary: { skills: ['C', 'C#', 'C++'] }).skills).to include 'C#'
      end
    end

    it 'returns ruby skill' do
      VCR.use_cassette 'vagas-analista-de-sistemas-java' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1276198/analista-de-sistemas-java', dictionary: { skills: ['Ruby'] }).skills).to include 'Ruby'
      end
    end

    it 'does not return C skill in C# job' do
      VCR.use_cassette 'vagas-analista-de-sistemas' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1261175/analista-de-sistemas', dictionary: { skills: ['C', 'C#', 'C++'] }).skills).to_not include 'C'
      end
    end

    it 'returns C and C++' do
      VCR.use_cassette 'vagas-analista-desenvolvedor-c' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1281695/analista-desenvolvedor-c', dictionary: { skills: ['C', 'C#', 'C++'] }).skills).to match_array %w(C++ C++ C)
      end
    end
  end

  describe '#focuses' do
    it 'returns the focuses' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr', dictionary: { focuses: ['Analista de Sistema'] }).focuses.uniq).to match_array ['Analista de Sistema']
      end
    end

    it 'doesnt return focuses from similar jobs' do
      VCR.use_cassette 'vagas-analista-de-sistemas-bi' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1266059/analista-de-sistemas-bi', dictionary: { focuses: ['Business Intelligence'] }).focuses).to be_empty
      end
    end
  end

  describe '#company' do
    it 'returns the company' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr').company).to eql 'Altran Consultoria em Tecnologia Ltda'
      end
    end
  end

  describe '#jobs' do
    it 'returns the jobs' do
      VCR.use_cassette 'vagas-ruby' do
        jobs = described_class.new(url: 'http://www.vagas.com.br/vagas-de-ruby').jobs
        expect(jobs.size).to eql 6
        expect(jobs.first.title).to eql 'Senior Data Analyst'
        expect(jobs.first.company).to eql 'Nokia Networks'
        expect(jobs.first.location).to eql 'Rio de Janeiro'
        expect(jobs.last.url).to eql 'http://www.vagas.com.br/vagas/v1271254/desenvolvedor-front-end-pleno-senior-zona-sul-sp'
      end
    end
  end
end
