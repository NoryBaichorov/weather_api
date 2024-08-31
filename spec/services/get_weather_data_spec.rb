# frozen_string_literal: true

require 'rails_helper'
require 'webmock'

RSpec.describe GetWeatherData, type: :service do
  WebMock.allow_net_connect!

  describe '.current_temperature', :vcr do
    it 'returns the current temperature' do
      temperature = GetWeatherData.current_temperature
      expect(temperature).to be_a(Numeric)
    end
  end

  describe '.historical_temperatures', :vcr do
    it 'returns historical temperatures' do
      temperatures = GetWeatherData.historical_temperatures
      expect(temperatures).to be_an(Array)
    end
  end
end
