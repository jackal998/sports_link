json.places do
  json.array! @places do |place|
    json.(place, :name, :id, :place_id, :latitude, :longitude, 
      :formatted_address, :address_components, :quality, :level, 
      :popularity, :openhour, :contact, :fee, :facility, :img)
    json.events do
      ['today','tomorrow','day_after'].each do |date|
        json.set! date do
          if @event = get_events_by_place_and_date(place, date).order('start_at').first
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