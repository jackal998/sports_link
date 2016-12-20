json.array! @places do |place|
  json.(place, :name, :id, :place_id, :latitude, :longitude, :formatted_address, :quality)
end

# json.array! (@users, {partial!: 'user', as: :user})
