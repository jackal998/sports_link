class PlacesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index, :create]

  def index
    
  end

  def create
    params[:params_to_post].each do |key,value|
      @place = Place.find_by_place_id(value[:place_id])
      unless @place
        @place = Place.new
        @place.name = value[:name]
        @place.latitude = value[:location][:lat]
        @place.longitude = value[:location][:lng]
        @place.place_id = value[:place_id]
        @place.long_name = value[:reference]
        @place.address_components = value[:vicinity]
        @place.quality = value[:rating]

        @place.save
      end
    end
    @events = @place.events
    if @events
      @events = @events.where("start_at > ? and start_at < ?", Time.now + 3600 * 8, Date.today + 1)
    end
  end

  def show
    @place = Place.find_by_place_id(params[:id])
    @events = @place.events
    if @events
      @events = @events.where("start_at > ? and start_at < ?", Time.now + 3600 * 8, Date.today + 1)
    end
  end
end
