require 'spec_helper'

describe Jobbie::Indeed do
  describe '#location' do
    it 'returns the location' do
      VCR.use_cassette 'indeed-a361c99a6feab476' do
        expect(described_class.new(url: 'http://www.indeed.com.br/viewjob?jk=a361c99a6feab476&q=ruby&l=Florian%C3%B3polis%2C+SC&tk=1a63n6vocd4evb7j&from=web').location).to eql 'Florianópolis'
      end
    end
  end

  describe '#seniority' do
    it 'returns the seniority' do
      VCR.use_cassette 'indeed-68f9e23429fd75c1' do
        expect(described_class.new(url: 'http://www.indeed.com.br/cmp/Shaw-and-Partners/jobs/Programador-J%C3%BAnior-68f9e23429fd75c1?q=ruby').seniority).to eql 'Júnior'
      end
    end
  end

  describe '#required_skills' do
    it 'returns the required skills' do
      VCR.use_cassette 'indeed-6302cd9dc565154a' do
        expect(described_class.new(url: 'http://www.indeed.com.br/cmp/Capitani-IT/jobs/Desenvolvedor-Ruby-Rails-Senior-6302cd9dc565154a?q=ruby', dictionary: { skills: %w(Java Ruby Python) }).required_skills).to include 'Ruby'
      end
    end
  end

  describe '#skills' do
    it 'returns the skills' do
      VCR.use_cassette 'indeed-a361c99a6feab476' do
        expect(described_class.new(url: 'http://www.indeed.com.br/viewjob?jk=a361c99a6feab476&q=ruby&l=Florian%C3%B3polis%2C+SC&tk=1a63n6vocd4evb7j&from=web', dictionary: { skills: %w(Java Ruby Python) }).skills).to match_array %w(Python Ruby Java)
      end
    end
  end

  describe '#focuses' do
    it 'returns the focuses' do
      VCR.use_cassette 'indeed-a361c99a6feab476' do
        expect(described_class.new(url: 'http://www.indeed.com.br/viewjob?jk=a361c99a6feab476&q=ruby&l=Florian%C3%B3polis%2C+SC&tk=1a63n6vocd4evb7j&from=web', dictionary: { focuses: ['Full Stack'] }).focuses.uniq).to match_array ['Full Stack']
      end
    end
  end

  describe '#company' do
    it 'returns the company' do
      VCR.use_cassette 'indeed-68f9e23429fd75c1' do
        expect(described_class.new(url: 'http://www.indeed.com.br/cmp/Shaw-and-Partners/jobs/Programador-J%C3%BAnior-68f9e23429fd75c1?q=ruby').company).to eql 'Shaw and Partners'
      end
    end
  end
end
