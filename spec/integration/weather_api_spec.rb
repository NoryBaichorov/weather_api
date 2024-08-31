# frozen_string_literal: true

require 'vcr'
require 'rails_helper'

RSpec.describe WeatherAPI, type: :request do
  def app
    Rails.application
  end

  describe 'GET /weather/current' do
    it 'returns current temperature' do
      VCR.use_cassette('weather_current') do
        get '/weather/current'
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/historical' do
    it 'returns sorted historical temperatures' do
      VCR.use_cassette('weather_historical') do
        get '/weather/historical'
        expect(response.status).to eq(200)
        data = JSON.parse(response.body)
        expect(data.first).to have_key('time')
        expect(data.first).to have_key('temperature')
      end
    end
  end

  describe 'GET /weather/historical/max' do
    it 'returns max historical temperature' do
      VCR.use_cassette('weather_historical_max') do
        get '/weather/historical/max'
        expect(response.status).to eq(200)
        data = JSON.parse(response.body)
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
        expect(response.status).to eq(200)
        data = JSON.parse(response.body)
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
        expect(response.status).to eq(200)
        data = JSON.parse(response.body)
        expect(data).to have_key('average_temperature')
      end
    end
  end

  describe 'GET /weather/health' do
    it 'returns health status' do
      get '/weather/health'
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('status' => 'OK')
    end
  end

  describe 'GET /by_time' do
    it 'returns the temperature for the closest time' do
      VCR.use_cassette('weather_by_time') do
        target_time = '1621823790'
        get "/weather/by_time?time=#{target_time}"
        expect(response.status).to eq(200)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('temperature')
      end
    end
  end
end