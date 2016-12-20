class Api::PlacesController < Api::BaseController
  before_action :authenticate_user!, :only => [:show]
  # skip_before_action :authenticate_user!, :only => [:index, :create]
  def index
    if params[:latitude].present? && params[:longitude].present?
      search_edge_from_arr = search_edge_from(params[:latitude].to_f,params[:longitude].to_f,1000)
      @places = Place.where(:longitude => search_edge_from_arr[0]..search_edge_from_arr[2], 
                            :latitude => search_edge_from_arr[1]..search_edge_from_arr[3])
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
      @events = @place.events
      if @events
        case params[:date]
        when 'day_after'
          @events = @events.where("start_at > ? and start_at < ?", Date.today + 2, Date.today + 3)
        when 'tomorrow'
          @events = @events.where("start_at > ? and start_at < ?", Date.today + 1, Date.today + 2)
        else 
          @events = @events.where("start_at > ? and start_at < ?", Time.now, Date.today + 1)
        end
      end
    else
      render json: { errors: 'No Place or Date Error' , needed: { id: 'place_id string', date: 'string: "today", "tomorrow" or "day_after"'}}, :status => 400
    end
  end
  private
  def search_edge_from(latitude,longitude,distance)
    lat_diff = distance / 110574.0
    lon_distance = 111320.0 * Math.cos(latitude*Math::PI/180)
    lon_diff = distance / lon_distance
    return [longitude - lon_diff, latitude - lat_diff, longitude + lon_diff, latitude + lat_diff]
  end
end
