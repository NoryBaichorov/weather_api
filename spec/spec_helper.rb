# frozen_string_literal: true

require 'vcr'
require 'rack/test'
require 'grape-swagger'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
end