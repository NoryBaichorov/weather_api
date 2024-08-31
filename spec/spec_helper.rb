# frozen_string_literal: true

require 'rack/test'
require 'grape-swagger'
require 'webmock/rspec'
require_relative 'support/vcr_setup'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
