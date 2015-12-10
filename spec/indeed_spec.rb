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

  describe '#jobs' do
    it 'returns the jobs' do
      VCR.use_cassette 'indeed-ruby' do
        jobs = described_class.new(url: 'http://www.indeed.com.br/empregos-de-ruby').jobs
        expect(jobs.size).to eql 15
        expect(jobs[3].title).to eql 'Desenvolvedor de Sistemas Ruby on Rails'
        expect(jobs[3].location).to eql 'São Paulo'
        expect(jobs.last.url).to eql 'http://www.indeed.com.br/pagead/clk?mo=r&ad=-6NYlbfkN0CawNMlk4i8BOZq58LzEEf46AoyWwrH8OkogGwNvj_yJoWAL4WLQ7W75OE8eQ1NqRBMNmrD4ZRyZCR1ad5GBXTBLI4yb6tFU8PDPgrLgqTGHvR6bJunjukO3fa-OSJtz2SAZFEdCCM-XNgG1hZzjo1hUJhPb5fNcNGDEDIO658D-_rp0k3_NhzKRUOy9_pUcNpiTBSuJZxMeAo79d3l-zpZVipZw0f8hqOiw3WCBgo0c4_AKg-EebbHKtTpa0QTGWj-AmsBFyhYL04dbP5I1y0G2t-3uQ-uI9Hwo7VtyJhQDkFreYPd0O2RcmmB9tOo8SxDtneevqoh-ym9cJPEdyUNu_iEqxVnCyIj8InY_PzXvRg4pwaYvQkQQ-ZL3aHmNAZ0HUVhenkszTdZfH_wx726ReRz84O9gqt7ITB1l88loLvqHgb8SK_qamdyWmzBumNBGMMvPJ242sXdU66sYUGZxWFTTrz4mZFAYI36uTp66kft68C7rIjoQ_onTXK4Gtm6MMbo5r9-FoB1U7027qUgysCl05s1vZ8qInNiXX0T0RvdOlRgh3_CggVCaqQg39gYZ0_SgO7s43b4ogeWBanSXYPNAG9gBL6sw4MBAEApbTzjUIwF1M63QUhDwr5CG0bCX_zvHK7pmR-SgNjdFyk1uxyGT1DV4A5ajAjSloupw4rF_sr0FoE78IEu2UR0AjxDjhqVC3kgRbzji3ulO0jRODfpn4knHjDKW9bZhLBssTS-p6xLx8VfgHX7vluxsmRZnSl8v9cOQ59qR7dI7IJa&p=5&sk=c54b9ad5825cc75d&fvj=0'
      end
    end
  end
end
