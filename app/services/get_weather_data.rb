# frozen_string_literal: true

class GetWeatherData
  LOCATION_KEY = '328328' # London
  API_KEY = 'OytuPRASa9u0Yii1pJ2gAZcF2vKpy4lY'
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
    required_data = []
    puts response.inspect  
    response.each do |res|
      parsed_data = Time.parse(res['LocalObservationDateTime']).strftime('%I:%M')
        
      required_data << {
        time: parsed_data,
        temperature: res['Temperature']['Metric']['Value']
      }
    end

    sorted_required_data = required_data.sort_by { |entry| entry[:time] }
    sorted_required_data
  end
end
