class BookFacade
  def initialize(location, quantity)
    @location = location
    @quantity = quantity
  end

  def books
    @_books ||= Book.new(book_search_data)
  end

  private

  def book_search_data
    {
      destination: @location,
      forecast: weather_forecast,
      total_books_found: total_books_found,
      books: book_data
    }
  end

  def weather_facade
    @_weather_facade ||= WeatherFacade.new(@location)
  end

  def library_service
    @_library_service ||= LibraryService.new.get_books(@location, @quantity)
  end

  def weather_forecast
    {
      summary: weather_facade.weather.current_weather[:conditions],
      temperature: weather_facade.weather.current_weather[:temperature]
    }
  end

  def book_data
    library_service[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end
  

  def total_books_found
    book_data.count
  end
end
