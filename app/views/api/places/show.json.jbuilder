json.place do
  json.(@place, :name, :id, :place_id, :latitude, :longitude, 
  :formatted_address, :address_components, :quality, :level, 
  :popularity, :openhour, :contact, :fee, :facility, :img)
  json.events @events do |event|
    json.(event, :id, :sport_name, :user_id, :characteristic_of_user, :start_at, :end_at)
    json.attended @attended_events.include?(event)
  end
end