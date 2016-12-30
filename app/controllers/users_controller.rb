class UsersController < ApplicationController
	def show
    @user = current_user
    @hosted_events = @user.events.includes(:place)
    @attended_events = @user.attended_events.where.not(user: @user).includes(:place)

    @hosted_events = get_events_by_date(@hosted_events, params[:date])
    @attended_events = get_events_by_date(@attended_events, params[:date])
  end
end
