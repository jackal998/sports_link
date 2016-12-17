class PlacesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index, :create]

  def index
    @place = Place.find_by_place_id(params[:place_id])
    if @place.present?
      @events = @place.events
      if @events
        case params[:date]
        when 'day_after'
          @events = @events.where("start_at > ? and start_at < ?", Date.today + 2, Date.today + 3)
        when 'tomorrow'
          @events = @events.where("start_at > ? and start_at < ?", Date.today + 1, Date.today + 2)
        else 
          @events = @events.where("start_at > ? and start_at < ?", Time.now + 3600 * 8, Date.today + 1)
        end
      end
      @event = @events.first
    end
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
        @place.reference = value[:reference]
        @place.address_components = value[:vicinity]
        @place.quality = value[:rating]
        @place.save
      end
    end
    @events = @place.events
    if @events
      @event = @events.where("start_at > ? and start_at < ?", Time.now + 3600 * 8, Date.today + 1).first
    end
  end

  def show
    @place = Place.find_by_place_id(params[:id])
    @events = @place.events
    if @events
      case params[:date]
      when 'day_after'
        @events = @events.where("start_at > ? and start_at < ?", Date.today + 2, Date.today + 3)
      when 'tomorrow'
        @events = @events.where("start_at > ? and start_at < ?", Date.today + 1, Date.today + 2)
      else 
        @events = @events.where("start_at > ? and start_at < ?", Time.now + 3600 * 8, Date.today + 1)
      end
    end
  end
end
