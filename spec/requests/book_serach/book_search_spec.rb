RSpec.describe 'API V1 Book Search', type: :request do
  describe 'GET /api/v0/book-search' do
    it 'returns the book search results' do
      location = 'denver,co'
      quantity = 5

      get '/api/v0/book-search', params: { location: location, quantity: quantity }
      expect(response).to have_http_status(:ok)
      
      body = JSON.parse(response.body)

      expect(body).to have_key('data')
      expect(body['data']).to have_key('id')
      expect(body['data']['id']).to be_nil

      expect(body['data']).to have_key('type')
      expect(body['data']['type']).to eq('book_search')

      expect(body['data']).to have_key('attributes')
      expect(body['data']['attributes']).to be_a(Hash)

      attributes = body['data']['attributes']

      expect(attributes).to have_key('destination')
      expect(attributes['destination']).to eq('denver,co')

      expect(attributes).to have_key('forecast')
      expect(attributes['forecast']).to be_a(Hash)

      forecast = attributes['forecast']

      expect(forecast).to have_key('summary')
      expect(forecast['summary']).to eq('Patchy light rain with thunder')

      expect(forecast).to have_key('temperature')
      expect(forecast['temperature']).to eq(59.0)

      expect(attributes).to have_key('total_books_found')
      expect(attributes['total_books_found']).to eq(5)

      expect(attributes).to have_key('books')
      expect(attributes['books']).to be_a(Array)
      expect(attributes['books'].length).to eq(5)

      books = attributes['books']

      books.each do |book|
        expect(book).to have_key('isbn')
        expect(book['isbn']).to be_a(Array)

        expect(book).to have_key('title')
        expect(book['title']).to be_a(String)

        expect(book).to have_key('publisher')
        expect(book['publisher']).to be_a(Array)
      end
    end
  end
end
