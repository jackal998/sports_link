class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_event, :only => [:update]

  def index
    # @place = Place.find_by_place_id(params[:place_id])
    @events = Event.where("start_at > ? ", Time.now).includes(:user)
  end 

  def new
    @place = Place.find_by_place_id(params[:place_id])
    @event = Event.new(:start_at => Time.now, :end_at => Time.now)
  end

  def create
    @place = Place.find_by_place_id(params[:place_id])
    
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

  # TODO: rename to join_event member route
  def update
    @event = Event.find(params[:id])
    
    # current_user.join_event(@event)
    unless @event.event_attendees.pluck(:user_id).include?(current_user.id)
      EventAttendee.create(:event_id => @event.id, :user_id => current_user.id)
    end

    @place = Place.find(@event.place.id)
  end

  def show
    # 這一頁是landing page!!
  end

  def match
    current_user.join_event(@event)
  end

  private
  def find_event
    @event = Event.find(params[:id])
  end
end
