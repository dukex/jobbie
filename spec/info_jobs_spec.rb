require 'spec_helper'

describe Jobbie::InfoJobs do
  describe '#location' do
    it 'returns the location' do
      VCR.use_cassette 'info-jobs-vaga-de-programacao-php-em-santa-catarina' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-programacao-php-em-santa-catarina__4795320.aspx').location).to eql 'Florianópolis'
      end
    end

    it 'returns nil when the job doesnt exist' do
      VCR.use_cassette 'info-jobs-desenvolvedor-ninja' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/desenvolvedor-ninja__4795321.aspx').location).to be_nil
      end
    end
  end

  describe '#seniority' do
    it 'returns the seniority' do
      VCR.use_cassette 'info-jobs-vaga-de-desenvolvedor-senior-back-end-em-santa-catarina' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-desenvolvedor-senior-back-end-em-santa-catarina__4857781.aspx').seniority).to eql 'Senior'
      end
    end
  end

  describe '#required_skills' do
    it 'returns the required skills' do
      VCR.use_cassette 'info-jobs-vaga-de-desenvolvedor-ruby-em-rio-grande-do-sul__4844101' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-desenvolvedor-ruby-em-rio-grande-do-sul__4844101.aspx', dictionary: { skills: %w(Java Ruby Python) }).required_skills).to include 'Ruby'
      end
    end
  end

  describe '#skills' do
    it 'returns the skills' do
      VCR.use_cassette 'info-jobs-vaga-de-desenvolvedor-senior-back-end-em-santa-catarina' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-desenvolvedor-senior-back-end-em-santa-catarina__4857781.aspx', dictionary: { skills: %w(Java Ruby Python) }).skills.uniq).to match_array %w(JAVA Java)
      end
    end
  end

  describe '#focuses' do
    it 'returns the focuses' do
      VCR.use_cassette 'info-jobs-vaga-de-desenvolvedor-senior-back-end-em-santa-catarina' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-desenvolvedor-senior-back-end-em-santa-catarina__4857781.aspx', dictionary: { focuses: ['Back End'] }).focuses.uniq).to match_array ['Back End']
      end
    end
  end

  describe '#company' do
    it 'returns the company' do
      VCR.use_cassette 'info-jobs-vaga-de-analista-programador-java-zona-leste-em-sao-paulo' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-analista-programador-java-zona-leste-em-sao-paulo__4879239.aspx').company).to eql 'SOFTMATIC'
      end
    end
  end

  describe '#jobs' do
    it 'returns the jobs' do
      VCR.use_cassette 'info-jobs-ruby' do
        jobs = described_class.new(url: 'http://www.infojobs.com.br/empregos.aspx?Palabra=ruby').jobs
        expect(jobs.size).to eql 15
        expect(jobs.first.title).to eql 'Programador Ruby On Rails'
        expect(jobs.first.location).to eql 'São Paulo'
        expect(jobs.first.company).to eql 'Retail'
        expect(jobs.last.url).to eql 'http://www.infojobs.com.br/vaga-de-analista-tecnologia-em-distrito-federal__4809760.aspx'
      end
    end
  end
end
