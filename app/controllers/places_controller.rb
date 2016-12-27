class PlacesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index, :create]

  def index
    # valid_and_save_data
    @place = Place.find_by_place_id(params[:place_id]) if params[:place_id]    
    @event = get_events_by_place_and_date(@place, params[:date]).first
  end

  def create
    @place = Place.find_by_place_id(params[:params_from_map][:place_id])
    unless @place
      @place = Place.new(
        name: params[:params_from_map][:name],
        latitude: params[:params_from_map][:location][:lat],
        longitude: params[:params_from_map][:location][:lng],
        place_id: params[:params_from_map][:place_id],
        reference: params[:params_from_map][:reference],
        address_components: params[:params_from_map][:vicinity],
        quality: params[:params_from_map][:rating]
      )
      @place.save
    end
    params[:distance] = params[:params_from_map][:distance]
    params[:date] = params[:params_from_map][:date]
    @event = get_events_by_place_and_date(@place, params[:params_from_map][:date]).first
  end

  def show
    @place = Place.find_by_place_id(params[:id])
    @events = get_events_by_place_and_date(@place, params[:date])
  end
  private
  def valid_and_save_data
    # if params[:name]
    #   unless Place.find_by_name(params[:name])
    #     facs = { 晚上場燈: '' ,附近廁所: '',附近飲水機: '' }
    #     facs[:晚上場燈] = params[:fac][0].include?('check')
    #     facs[:附近廁所] = params[:fac][1].include?('check')
    #     facs[:附近飲水機] = params[:fac][2].include?('check')
    #     @place = Place.new
    #     @place.name = params[:name]
    #     @place.quality = params[:score].to_i
    #     @place.latitude = params[:link].split('&q=')[1].split(',')[0].to_f
    #     @place.longitude = params[:link].split('&q=')[1].split(',')[1].to_f
    #     @place.level = params[:ratyrate][0].to_f
    #     @place.popularity = params[:ratyrate][1].to_f
    #     @place.openhour = params[:context][1]
    #     @place.contact = params[:context][3]
    #     @place.fee = params[:context][5]
    #     @place.facility = facs
    #     @place.formatted_address = params[:context][7]
    #     if params[:img].split('http')[1]
    #       @place.img = params[:img].split('"')[1]
    #     else
    #       @place.img = 'http://tw.basketball.biji.co' + params[:img].split('"')[1]
    #     end
    #     @place.place_id = SecureRandom.uuid
    #     @place.address_components = params[:context][11]
    #     @place.save
    #   end
    # end
  end
end
