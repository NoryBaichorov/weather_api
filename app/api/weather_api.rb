# frozen_string_literal: true

require 'time'
require 'grape'
require_relative '../services/get_weather_data'

class WeatherAPI < Grape::API
  format :json

  resource :weather do
    get '/current' do
      { temperature: GetWeatherData.current_temperature }
    end

    get '/historical' do
      GetWeatherData.parse_and_sort_historical_data
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
      
      entry = data.sum { |entry| entry[:temperature] }
      
      avg_temperature = entry / data.size.to_f
      
      { average_temperature: avg_temperature }
    end

    get '/by_time' do
      time = params['time'].to_i
      data = GetWeatherData.parse_and_sort_historical_data

      # Преобразуем timestamp в объект времени
      target_time = Time.at(time)

      # Находим запись с ближайшим временем
      closest_entry = data.min_by do |entry|
        (Time.parse(entry[:time]) - target_time).abs
      end

      # Проверяем, совпадает ли время
      closest_time = Time.parse(closest_entry[:time])

      if closest_time
        { temperature: closest_entry[:temperature] }
      else
        { error: "Temperature for the given timestamp not found", status: 404 }
      end
    end

    get '/health' do
      { status: 'OK' }
    end
  end
  add_swagger_documentation
end
