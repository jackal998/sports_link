class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :find_event, :only => [:update, :show]

  def index
    @place = Place.find_by_place_id(params[:place_id])
    @events = Event.where(:place_id => params[:place_id]).includes(:user)
  end 

  def new
    @place = Place.find_by_place_id(params[:place_id])
    @event = Event.new(place_id: params[:place_id], user_id: current_user.id, start_at: params[:selected_time])
  end  

  def create
    @place = Place.find_by_place_id(params[:place_id])
    @event = Event.new(place_id: params[:place_id], user_id: current_user.id, start_at: params[:selected_time])
    if @event.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    unless @event.event_attendees.pluck(:user_id).include?(current_user.id)
      EventAttendee.create(:event_id => @event.id, :user_id => current_user.id)
    end
  end

  def show

  end

  def match
  end

  private
  def find_event
    @event = Event.find(params[:id])
  end
end
