class Event < ApplicationRecord
  belongs_to :place
  belongs_to :user

  validates_presence_of :start_at
end
