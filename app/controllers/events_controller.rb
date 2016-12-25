class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_event, :only => [:update]
  before_action :find_place, :except => [:index]

  def index
    # @place = Place.find_by_place_id(params[:place_id])
    @events = Event.where("start_at > ? ", Time.now).includes(:user)
  end 

  def new
    @event = Event.new(:start_at => Time.now, :end_at => Time.now)
  end

  def create
    case params[:date]
      when 'day_after'
        start_at = params[:event][:start_at].to_time.advance(days: 2)
        end_at = params[:event][:end_at].to_time.advance(days: 2)
      when 'tomorrow'
        start_at = params[:event][:start_at].to_time.advance(days: 1)
        end_at = params[:event][:end_at].to_time.advance(days: 1)
      else
        start_at = params[:event][:start_at].to_time
        end_at = params[:event][:end_at].to_time
    end

    @event = Event.new(place_id: @place.id, user_id: current_user.id, start_at: start_at, end_at: end_at, characteristic_of_user: params[:event][:characteristic_of_user])
    unless @event.save
      redirect_to event_path(@event)
    end
    current_user.join_event(@event)
  end

  def join
    @event = Event.find(params[:id])
    
    current_user.join_event(@event)
  end

  private
  def find_event
    @event = Event.find(params[:id])
  end
  def find_place
    @place = Place.find_by_place_id(params[:place_id])
  end
end
