class Api::EventsController < Api::BaseController
  before_action :authenticate_user!
  before_action :find_event, :only => [:join, :show]
  before_action :find_place, :only => [:new, :create, :update]

  # def index
  #   render json: { errors: 'Oops! something is broken, We\'ll soon fix it!'}, :status => 400
  # end 

  def new
    @place = Place.find_by_place_id(params[:place_id])
    @event = Event.new(:start_at => Time.now, :user => current_user)
  end 

  def create
    start_at, end_at = params[:start_at].to_time, params[:end_at].to_time

    @event = Event.new(
      place: @place, user: current_user, start_at: start_at, end_at: end_at,
      characteristic_of_user: params[:characteristic_of_user])
    if (end_at - start_at) > 0
      @event = Event.new(place: @place, user: current_user, start_at: start_at, end_at: end_at, characteristic_of_user: params[:event][:characteristic_of_user])
      current_user.join_event(@event)
      unless @event.save
        render json: { errors: @event.errors.full_messages }, status: 402
      end
    else
      render json: { errors: '結束時間需晚於開始時間！，新增失敗' }, status: 400
    end

  end

  def join
    current_user.join_event(@event)
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
    @event = Event.find_by_id(params[:id]) if params[:id].present?
    render json: { errors: 'No Evnet Error', needed: {id: 'integer'}}, :status => 400 unless @event
  end
end
