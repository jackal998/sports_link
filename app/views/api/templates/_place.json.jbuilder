json.(place, :name, :id, :place_id, :latitude, :longitude, 
  :formatted_address, :address_components, :drink, :restroom, :parking, 
  :level, :basket, :courts, :light, :level, :img)
if Dir["public/images/places/#{place.place_id}.jpg"].present?
  json.img image_url "places/#{place.place_id}.jpg"
end