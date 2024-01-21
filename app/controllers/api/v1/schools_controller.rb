module Api
  module V1
    class Api::V1::SchoolsController < ApplicationController

    require 'net/http'

    def get_schools
      location = params[:location]
      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location}&fields=types,rating,name,rating,user_ratings_total&radius=500&type=school&key=AIzaSyCVPy4OvXyq9bGgTy6vbU7QQN6fRgvjZRY"

      uri = URI(url)
      response = Net::HTTP.get(uri)
      render json: response
    end
  end

end
end
  