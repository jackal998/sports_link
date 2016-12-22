class Place < ApplicationRecord
  has_many :events, :dependent => :destroy
  
  validates_presence_of :name, :latitude, :longitude


  def self.find_by_lat_and_long(latitude, longitude, distance)
      search_edge_from_arr = search_edge_from(latitude, longitude, distance)
      
      where(:longitude => search_edge_from_arr[0]..search_edge_from_arr[2], 
            :latitude => search_edge_from_arr[1]..search_edge_from_arr[3])
  end

  private
  def self.search_edge_from(latitude,longitude,distance)
    lat_diff = distance / 110574.0
    lon_distance = 111320.0 * Math.cos(latitude*Math::PI/180)
    lon_diff = distance / lon_distance
    return [longitude - lon_diff, latitude - lat_diff, longitude + lon_diff, latitude + lat_diff]
  end

end
