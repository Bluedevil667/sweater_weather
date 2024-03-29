class RoadTripFacade < WeatherFacade
  def initialize(locations)
    @origin = locations[:origin]
    @destination = locations[:destination]
    if directions_data.key?(:locations)
      @dest_lat = directions_data[:locations][1][:latLng][:lat]
      @dest_lon = directions_data[:locations][1][:latLng][:lng]
    end
  end

  def road_trip
    if directions_data.key?(:routeError)
      RoadTrip.new(error_trip)
    else
      RoadTrip.new(road_trip_data)
    end
  end

  private
  def time_at_destination
    @_arrival_time ||= Time.now.in_time_zone(Timezone.lookup(@dest_lat, @dest_lon).name) + directions_data[:time]
  end
  
  def weather_at_destination_day
    @_day ||= destination_weather_data.find do |day|
      day[:date] == time_at_destination.strftime('%Y-%m-%d')
    end
  end
  
  def weather_at_destination_hour
    @_hour ||= weather_at_destination_day[:hour].find do |hour|
      hour[:time] == time_at_destination.strftime("%Y-%m-%d %H:00")  
    end  
  end
  
  def directions_data
    @_directions_data ||= location_service&.get_directions(@origin, @destination)[:route]
  end

  def destination_weather_data
    @_destination_weather_data ||= weather_service.get_weather(@dest_lat, @dest_lon)[:forecast][:forecastday]
  end
  
  def road_trip_data
    {
      start_city: @origin,
      end_city: @destination,
      travel_time: directions_data[:formattedTime],
      weather_at_eta: {
        datetime: weather_at_destination_hour[:time],
        temperature: weather_at_destination_hour[:temp_f],
          conditions: weather_at_destination_hour[:condition][:text]
        }
      }
    end

    def error_trip
      {
        start_city: @origin,
        end_city: @destination,
        travel_time: "impossible",
        weather_at_eta: {}
      }
    end
end