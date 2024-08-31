# frozen_string_literal: true

require 'rack/test'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end