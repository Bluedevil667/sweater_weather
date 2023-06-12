class Api::V1::BookSearchController < ApplicationController
  def index
    render json: BookSearchSerializer.new(BookFacade.new(params[:location], params[:quantity]).books)
  end
end
