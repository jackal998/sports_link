class Place < ApplicationRecord
  has_many :events, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_uniqueness_of :long_name

end
