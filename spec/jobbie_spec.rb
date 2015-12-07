require 'spec_helper'

describe Jobbie do
  it 'has a version number' do
    expect(Jobbie::VERSION).not_to be nil
  end
end

describe Jobbie::Vagas do
  describe '#location' do
    it 'returns the location' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr').location).to eql 'São Paulo'
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

  describe '#keywords' do
    it 'returns the keywords' do
      VCR.use_cassette 'vagas-analista-de-sistema-sr' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1257642/analista-de-sistema-sr', dictionary: %w(Java Ruby Python)).keywords).to match_array %w(JAVA)
      end
    end

    it 'doesnt return keywords from similar jobs' do
      VCR.use_cassette 'vagas-analista-de-sistemas-bi' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1266059/analista-de-sistemas-bi', dictionary: ['Business Intelligence']).keywords).to be_empty
      end
    end

    it 'doesnt return keywords from another jobs from the company' do
      VCR.use_cassette 'vagas-analista-de-sistemas-sharepoint-pleno' do
        expect(described_class.new(url: 'http://www.vagas.com.br/vagas/v1253580/analista-de-sistemas-sharepoint-pleno', dictionary: ['DotNet']).keywords).to be_empty
      end
    end
  end
end
