json.place do
  json.(@place, :name, :id, :place_id, :latitude, :longitude, :formatted_address, :quality)
  json.event_format do
    json.(@event, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at)
  end
end