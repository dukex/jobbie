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

  describe '#skills' do
    it 'returns the skills' do
      VCR.use_cassette 'info-jobs-vaga-de-desenvolvedor-senior-back-end-em-santa-catarina' do
        expect(described_class.new(url: 'http://www.infojobs.com.br/vaga-de-desenvolvedor-senior-back-end-em-santa-catarina__4857781.aspx', dictionary: { skills: %w(Java Ruby Python) }).skills).to match_array %w(Java)
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
end
