json.search_radius params[:radius]
json.places do
  json.array! @places do |place|
    json.(place, :name, :id, :place_id, :latitude, :longitude, 
    :formatted_address, :address_components, :drink, :restroom, :parking, 
    :level, :basket, :courts, :light, :level, :img)
    json.events do
      ['today','tomorrow','day_after'].each do |date|
        json.set! date do
          @event = get_events_by_date(place.events, date).first
          if @event
            json.(@event, :id, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at) 
            json.attended @attended_events.include?(@event)
          else
            json.null!
          end
        end
      end
    end
  end
end