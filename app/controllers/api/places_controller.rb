class Api::PlacesController < Api::BaseController
  before_action :authenticate_user!

  def index
    if params[:latitude].present? && params[:longitude].present?
      @places = Place.find_by_lat_and_long(params[:latitude].to_f, params[:longitude].to_f, 500).includes(:events)
      params[:radius] = 500
      unless @places.present?
        @places = Place.find_by_lat_and_long(params[:latitude].to_f, params[:longitude].to_f, 1000).includes(:events)
        params[:radius] = 1000
        unless @places.present?
          @places = Place.find_by_lat_and_long(params[:latitude].to_f, params[:longitude].to_f, 2000).includes(:events)
          params[:radius] = 2000
        end
      end
      @attended_events = current_user.attended_events
    else
      render json: { errors: 'No Position Error' , needed: { latitude: 'float', longitude: 'float'}}, :status => 400
    end
  end

  # def create
  #   render json: { errors: 'Oops! something is broken, We\'ll soon fix it!'}, :status => 400
  # end

  def show
    if params[:id].present? && params[:date].present?
      @place = Place.find_by_place_id(params[:id])
      @events = get_events_by_place_and_date(@place, params[:date])
      @attended_events = current_user.attended_events
    else
      render json: { errors: 'No Place or Date Error' , needed: { id: 'place_id string', date: 'string: "today", "tomorrow" or "day_after"'}}, :status => 400
    end
  end
  
end
