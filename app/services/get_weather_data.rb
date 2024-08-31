# frozen_string_literal: true

class GetWeatherData
  LOCATION_KEY = '328328' # London
  API_KEY = 'sAFC1VKL7m1IcSZrKCQhboOyQIaiI4wv'
  BASE_URL = 'https://dataservice.accuweather.com'

  def self.current_temperature
    Rails.cache.fetch('current_temperature', expires_in: 15.minutes) do
      response = HTTParty.get("#{BASE_URL}/currentconditions/v1/#{LOCATION_KEY}?apikey=#{API_KEY}")
      JSON.parse(response.body).first['Temperature']['Metric']['Value']
    end
  end

  def self.historical_temperatures
    Rails.cache.fetch('historical_temperatures', expires_in: 15.minutes) do
      response = HTTParty.get("#{BASE_URL}/currentconditions/v1/#{LOCATION_KEY}/historical/24?apikey=#{API_KEY}")
      JSON.parse(response.body)
    end
  end

  private

  def self.parse_and_sort_historical_data
    response = GetWeatherData.historical_temperatures

    final_hash = []

    response.each do |res|
      parsed_data = Time.parse(res['LocalObservationDateTime']).strftime('%I:%M')
        
      final_hash << {
        time: parsed_data,
        temperature: res['Temperature']['Metric']['Value']
      }
    end

    sorted_final_hash = final_hash.sort_by { |entry| entry[:time] }
    sorted_final_hash
  end
end
