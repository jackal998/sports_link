class Api::EventsController < Api::BaseController
  before_action :authenticate_user!, :except => [:index]
  before_action :find_event, :only => [:join, :show]
  before_action :find_place, :only => [:new, :create, :update]

  def index
    render json: { errors: 'Oops! something is broken, We\'ll soon fix it!'}, :status => 400
  end 

  def new
    @place = Place.find_by_place_id(params[:place_id])
    @event = Event.new(:start_at => Time.now, :user => current_user)
  end 

  def create
    @event = Event.new(
      place: @place, user: current_user, start_at: params[:start_at], end_at: params[:end_at],
      characteristic_of_user: params[:characteristic_of_user])
    unless @event.save
      render json: { errors: @event.errors.full_messages }, status: 402
    end
  end

  def join
    unless @event.event_attendees.pluck(:user_id).include?(current_user.id)
      EventAttendee.create(:event => @event, :user => current_user)
    end
    @place = Place.find(@event.place_id)
  end

  private
  def find_place
    if params[:place_id].present?
      @place = Place.find_by_place_id(params[:place_id])
    else
      render json: { errors: 'No Place Error', needed: {place_id: 'string'}}, :status => 400
    end 
  end
  def find_event
    if params[:id].present?
      @event = Event.find(params[:id])
    else
      render json: { errors: 'No Evnet Error', needed: {id: 'integer'}}, :status => 400
    end
  end
end
