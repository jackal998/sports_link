class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :find_event, :only => [:update, :show]

  def index
    @place = Place.find_by_place_id(params[:place_id])
    @events = Event.where(:place_id => params[:place_id]).includes(:user)
  end 

  def new
    @place = Place.find_by_place_id(params[:place_id])
    @event = Event.new(:start_at => Time.now.strftime("%I:%M%p"), :end_at => (Time.now + 2 * 3600).strftime("%I:%M%p"))
  end 

  def create
    @place = Place.find_by_place_id(params[:place_id])
    @event = @event = Event.new(place_id: @place.id, user_id: current_user.id, start_at: params[:event][:start_at], end_at: params[:event][:end_at])
    unless @event.save
      redirect_to event_path(@event)
    end
  end

  def update
    @event = Event.find(params[:id])
    unless @event.event_attendees.pluck(:user_id).include?(current_user.id)
      EventAttendee.create(:event_id => @event.id, :user_id => current_user.id)
    end
    @place = Place.find(@event.place.id)
  end

  def show
    byebug
  end

  def match
  end

  private
  def find_event
    @event = Event.find(params[:id])
  end
end
