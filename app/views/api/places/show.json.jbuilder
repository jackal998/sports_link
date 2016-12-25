json.place do
  json.(@place, :name, :id, :place_id, :latitude, :longitude, :formatted_address, :quality)
  json.events @events do |event|
    json.(event, :id, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at, :created_at, :updated_at)
  end
end