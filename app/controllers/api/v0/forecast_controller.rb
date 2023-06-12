class Api::V0::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(WeatherFacade.new(params[:location]).weather)
  end
end