# Jobbie

Jobbie parses the job pages from different sites:

* [99jobs](https://www.99jobs.com/)
* [Indeed](http://www.indeed.com.br/)
* [InfoJobs](http://www.infojobs.com.br/)
* [Trampos](http://trampos.co/)
* [Vagas](http://www.vagas.com.br/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jobbie'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jobbie

## Usage

``` ruby
url = 'http://trampos.co/oportunidades/123939'
dictionary = { skills: %(Java Ruby Python ...), focuses: %w(Back-end Front-end Analytics ...) }

# Factory automatically detects the site by the URL
job = Jobbie::Factory.init url: url, dictionary: dictionary

# OR

job == Jobbie::Trampos.new url: url, dictionary: dictionary

# THEN

job.location
job.seniority
job.skills
job.required_skills
job.focuses
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/contratadome/jobbie.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

