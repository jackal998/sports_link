class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def get_events_by_place_and_date(place, date)
    return [] unless place
    case date
      when 'day_after'
        place.events.during( (Date.today + 2).beginning_of_day, (Date.today + 2).end_of_day)
      when 'tomorrow'
        place.events.during( (Date.today + 1).beginning_of_day, (Date.today + 1).end_of_day)
      else 
        place.events.during( Time.now, Date.today.end_of_day )
    end
  end

end
