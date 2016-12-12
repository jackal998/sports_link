class Event < ApplicationRecord
  belongs_to :place
  belongs_to :user

  has_many :event_attendees, :dependent => :destroy
  has_many :attendees, :through => "event_attendees", :source => "user"

  validates_presence_of :start_at
end
