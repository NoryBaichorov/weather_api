# frozen_string_literal: true

require 'spec_helper'
require 'vcr'
require_relative '../../app/api/weather_api'

describe WeatherAPI do
  include Rack::Test::Methods

  def app
    WeatherAPI
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'spec/vcr_cassettes'
    config.hook_into :webmock
  end

  describe 'GET /weather/current' do
    it 'returns current temperature' do
      VCR.use_cassette('weather_current') do
        get '/weather/current'
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/historical' do
    it 'returns sorted historical temperatures' do
      VCR.use_cassette('weather_historical') do
        get '/weather/historical'
        expect(last_response.status).to eq(200)
        data = JSON.parse(last_response.body)
        expect(data).to be_an(Array)
        expect(data.first).to have_key('time')
        expect(data.first).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/historical/max' do
    it 'returns max historical temperature' do
      VCR.use_cassette('weather_historical_max') do
        get '/weather/historical/max'
        expect(last_response.status).to eq(200)
        data = JSON.parse(last_response.body)
        expect(data).to have_key('max_temperature')
        expect(data['max_temperature']).to have_key('time')
        expect(data['max_temperature']).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/historical/min' do
    it 'returns min historical temperature' do
      VCR.use_cassette('weather_historical_min') do
        get '/weather/historical/min'
        expect(last_response.status).to eq(200)
        data = JSON.parse(last_response.body)
        expect(data).to have_key('min_temperature')
        expect(data['min_temperature']).to have_key('time')
        expect(data['min_temperature']).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/historical/avg' do
    it 'returns average historical temperature' do
      VCR.use_cassette('weather_historical_avg') do
        get '/weather/historical/avg'
        expect(last_response.status).to eq(200)
        data = JSON.parse(last_response.body)
        expect(data).to have_key('average_temperature')
        expect(data['average_temperature']).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/health' do
    it 'returns health status' do
      get '/weather/health'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq('status' => 'OK')
    end
  end
end