class UsersController < ApplicationController
	def show
    @user = current_user
    @hosted_events = @user.events.selected
    @attended_events = @user.attended_events.selected
    # @place = Place.find_by_place_id(params[:place_id]) if params[:place_id]    
    # @event = get_events_by_place_and_date(@place, params[:date]).first
  end
end
