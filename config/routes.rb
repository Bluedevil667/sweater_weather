Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecast#index'
      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#create'
    end
    namespace :v1 do
      get '/book-search', to: 'book_search#index'
    end
  end
end
