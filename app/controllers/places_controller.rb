class PlacesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index, :create]

  def index
    @place = Place.find_by_place_id(params[:place_id]) if params[:place_id]    
    @event = get_events_by_place_and_date(@place, params[:date]).first
  end

  def create
    params[:params_to_post].each do |key, value|
      @place = Place.find_by_place_id(value[:place_id])
      unless @place
        @place = Place.new
        @place.name = value[:name]
        @place.latitude = value[:location][:lat]
        @place.longitude = value[:location][:lng]
        @place.place_id = value[:place_id]
        @place.reference = value[:reference]
        @place.address_components = value[:vicinity]
        @place.quality = value[:rating]
        @place.save
      end
    end
    
    @event = get_events_by_place_and_date(@place, params[:params_to_post]["0"][:date]).first
  end

  def show
    @place = Place.find_by_place_id(params[:id])
    @events = get_events_by_place_and_date(@place, params[:date])
  end

end
