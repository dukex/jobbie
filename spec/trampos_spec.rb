require 'spec_helper'

describe Jobbie::Trampos do
  describe '#location' do
    it 'returns the location' do
      VCR.use_cassette 'trampos-123892' do
        expect(described_class.new(url: 'http://trampos.co/oportunidades/123892?tr=ruby').location).to eql 'São Paulo'
      end
    end
  end

  describe '#seniority' do
    it 'returns the seniority' do
      VCR.use_cassette 'trampos-123892' do
        expect(described_class.new(url: 'http://trampos.co/oportunidades/123892?tr=ruby').seniority).to eql 'Pleno'
      end
    end
  end

  describe '#required_skills' do
    it 'returns the required skills' do
      VCR.use_cassette 'trampos-123767' do
        expect(described_class.new(url: 'http://trampos.co/oportunidades/123767?tr=ruby', dictionary: { skills: %w(Java Ruby Python) }).required_skills).to include 'Ruby'
      end
    end
  end

  describe '#skills' do
    it 'returns the skills' do
      VCR.use_cassette 'trampos-123892' do
        expect(described_class.new(url: 'http://trampos.co/oportunidades/123892?tr=ruby', dictionary: { skills: %w(Java Ruby Python) }).skills).to match_array %w(Java Ruby)
      end
    end

    it 'doesnt return skills from content that is not from the job' do
      VCR.use_cassette 'trampos-123767' do
        skills = described_class.new(url: 'http://trampos.co/oportunidades/123767?tr=ruby', dictionary: { skills: %w(SEO SEM) }).skills
        expect(skills).to_not include 'SEO'
        expect(skills).to_not include 'SEM'
      end
    end
  end

  describe '#focuses' do
    it 'returns the focuses' do
      VCR.use_cassette 'trampos-123892' do
        expect(described_class.new(url: 'http://trampos.co/oportunidades/123892?tr=ruby', dictionary: { focuses: ['Back End'] }).focuses.uniq).to match_array ['Back-end']
      end
    end
  end

  describe '#company' do
    it 'returns the company' do
      VCR.use_cassette 'trampos-123892' do
        expect(described_class.new(url: 'http://trampos.co/oportunidades/123892?tr=ruby').company).to eql 'Braza Digital'
      end
    end
  end
end
