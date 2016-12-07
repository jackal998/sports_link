class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  def match
    byebug
  end
end
