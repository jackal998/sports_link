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

  def self.show_only(date)
    return [] unless self
    case date
      when 'day_after'
        self.all.map {|e| e if (e.start_at >= (Date.today + 2).beginning_of_day && e.start_at <= (Date.today + 2).end_of_day) }.compact
      when 'tomorrow'
        self.all.map {|e| e if (e.start_at >= (Date.today + 1).beginning_of_day && e.start_at <= (Date.today + 1).end_of_day) }.compact
      else 
        self.all.map {|e| e if (e.start_at >= Time.now && e.start_at <= Date.today.end_of_day) }.compact
    end
  end
end
