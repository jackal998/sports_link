class Event < ApplicationRecord
  belongs_to :place
  belongs_to :user

  has_many :event_attendees, :dependent => :destroy
  has_many :attendees, :through => "event_attendees", :source => "user"

  validates_presence_of :start_at
  validates_presence_of :end_at

  default_scope -> { where('start_at >= ?', Time.now).order('start_at') }

  def self.during(start_at, end_at)
    where("start_at >= ? and start_at < ?", start_at, end_at) 
  end
end
