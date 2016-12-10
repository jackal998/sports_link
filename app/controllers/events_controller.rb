class EventsController < ApplicationController
  def index
    @events = Event.all

  end
  def create
    byebug
  end
  def match
  end
end
