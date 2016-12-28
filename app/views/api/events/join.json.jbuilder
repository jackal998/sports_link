json.place do
  json.(@place, :name, :id, :place_id, :latitude, :longitude, 
  :formatted_address, :address_components, :drink, :restroom, :parking, 
  :level, :basket, :courts, :light, :level, :img)
  json.event do
    json.(@event, :id, :sport_name, :user_id, :characteristic_of_user, :start_at, :end_at, :created_at, :updated_at)
  end
end