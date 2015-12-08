# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jobbie/version'

Gem::Specification.new do |spec|
  spec.name          = "jobbie"
  spec.version       = Jobbie::VERSION
  spec.authors       = ["Diego Carrion"]
  spec.email         = ["tech@contratado.me"]

  spec.summary       = %q{A jobs crawler and parser}
  spec.homepage      = "https://github.com/contratadome/jobbie"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
