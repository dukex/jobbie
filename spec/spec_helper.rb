$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jobbie'
require 'byebug'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end
