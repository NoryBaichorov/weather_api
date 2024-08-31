# frozen_string_literal: true

require 'time'
require 'grape'
require_relative '../../lib/array_extensions'
require_relative '../services/get_weather_data'

class WeatherAPI < Grape::API
  include ArrayExtensions
  
  format :json

  resource :weather do
    get '/current' do
      { temperature: GetWeatherData.current_temperature }
    end

    get '/historical' do
      GetWeatherData.parse_and_sort_historical_data.to_json
    end

    get '/historical/max' do
      data = GetWeatherData.parse_and_sort_historical_data
      
      entry = data.max_by { |entry| entry[:temperature] }

      { max_temperature: { time: entry[:time], temperature: entry[:temperature] } }
    end

    get '/historical/min' do
      data = GetWeatherData.parse_and_sort_historical_data
      
      entry = data.min_by { |entry| entry[:temperature] }
      
      { min_temperature: { time: entry[:time], temperature: entry[:temperature] } }
    end

    get '/historical/avg' do
      data = GetWeatherData.parse_and_sort_historical_data
      
      entry = data.avg_by { |entry| entry[:temperature] }
      
      { average_temperature: { time: entry[:time], temperature: entry[:temperature] } }
    end

    get '/by_time' do
      # Логика для получения температуры по timestamp
    end

    get '/health' do
      { status: 'OK' }
    end
  end
  add_swagger_documentation
end
