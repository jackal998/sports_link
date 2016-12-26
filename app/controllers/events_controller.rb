class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_event, :only => [:update]
  before_action :find_place, :except => [:index]

  def index
    # @place = Place.find_by_place_id(params[:place_id])
    @events = Event.where("start_at > ? ", Time.now).includes(:user)
  end 

  def new
    case params[:date]
      when 'day_after'
        start_at , end_at = (Date.today + 2).beginning_of_day, (Date.today + 2).end_of_day
      when 'tomorrow'
        start_at , end_at = (Date.today + 1).beginning_of_day, (Date.today + 1).end_of_day
      else 
        start_at , end_at = Time.now, (Date.today + 1).end_of_day
    end
    @event = Event.new(:start_at => start_at.strftime('%I:%M%p'), :end_at => end_at.strftime('%I:%M%p'))
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
    if (end_at - start_at) > 0
      @event = Event.create(place: @place, user: current_user, start_at: start_at, end_at: end_at, characteristic_of_user: params[:event][:characteristic_of_user])
      current_user.join_event(@event)
    else
      redirect_to :back, flash: {alert: '結束時間需晚於開始時間！'}
    end
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
