class EventsController < ApplicationController
  def index
    @events = Event.all

  end
  def create
    permitted_params = place_params
    @place = Place.find_by_place_id(permitted_params['place_id'])
    unless @place
      @place = Place.new(
        :place_id=> permitted_params['place_id'],
        :name=> permitted_params['address_components0']['short_name'],
        :long_name=> permitted_params['address_components0']['long_name'],
        :latitude=> permitted_params['latitude'],
        :longitude=> permitted_params['longitude'],
        :formatted_address=> permitted_params['formatted_address']
        )
      @place.save
    end
  end
  def match
  end

  private
  def place_params
    info = {}
    params[:params_to_post].each_pair do |key, information| 
      information.each_pair do |title, value|
        if title == "address_components"
          value.each_pair do |component_index,component|
            cmpnt = {}
            component.each_pair do |component_title, component_value|
              cmpnt.store( component_title , component_value ) unless component_index == 0
            end
            info.store("address_components#{component_index}", cmpnt )
          end
        else
          info.store(title, value)
        end
      end
    end
    return info
  end
end
