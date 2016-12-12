class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :find_event, :only => [:update, :show]

  def index
    @place = Place.find(params[:place_id])
    @events = Event.where(:place_id => params[:place_id]).includes(:user)
    @events = @events.where()
  end

  def create
    @event = Event.new(place_id: params[:place_id], user_id: current_user.id, start_at: params[:selected_time])

    if @event.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to events_path
    end
    # permitted_params = place_params
    # @place = Place.find_by_place_id(permitted_params['place_id'])
    # unless @place
    #   @place = Place.new(
    #     :place_id=> permitted_params['place_id'],
    #     :name=> permitted_params['address_components0']['short_name'],
    #     :long_name=> permitted_params['address_components0']['long_name'],
    #     :latitude=> permitted_params['latitude'],
    #     :longitude=> permitted_params['longitude'],
    #     :formatted_address=> permitted_params['formatted_address']
    #     )
    #   @place.save
    # end
  end

  def update
    
  end

  def show


  end

  def match
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end
  # def place_params
  #   info = {}
  #   params[:params_to_post].each_pair do |key, information| 
  #     information.each_pair do |title, value|
  #       if title == "address_components"
  #         value.each_pair do |component_index,component|
  #           cmpnt = {}
  #           component.each_pair do |component_title, component_value|
  #             cmpnt.store( component_title , component_value ) unless component_index == 0
  #           end
  #           info.store("address_components#{component_index}", cmpnt )
  #         end
  #       else
  #         info.store(title, value)
  #       end
  #     end
  #   end
  #   return info
  # end
end
