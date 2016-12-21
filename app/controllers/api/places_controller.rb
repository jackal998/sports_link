class Api::PlacesController < Api::BaseController
  before_action :authenticate_user!, :only => [:show]
  # skip_before_action :authenticate_user!, :only => [:index, :create]
  def index
    if params[:latitude].present? && params[:longitude].present?    
      @places = Place.find_by_lat_and_long(params[:latitude].to_f, params[:longitude].to_f, 1000)
    else
      render json: { errors: 'No Position Error' , needed: { latitude: 'float', longitude: 'float'}}, :status => 400
    end
  end

  def create
    render json: { errors: 'Oops! something is broken, We\'ll soon fix it!'}, :status => 400
  end

  def show
    if params[:id].present? && params[:date].present?
      @place = Place.find_by_place_id(params[:id])
      @events = get_events_by_place_and_date(@place, params[:date])
    else
      #render json: { errors: 'Invalid date format' , needed: { date: 'string: "today", "tomorrow" or "day_after"'}}, :status => 400
      render json: { errors: 'No Place or Date Error' , needed: { id: 'place_id string', date: 'string: "today", "tomorrow" or "day_after"'}}, :status => 400
    end
  end
  
end
