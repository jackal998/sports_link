class UsersController < ApplicationController
	def show
    @user = current_user
    @hosted_events = @user.events.includes(:place)
    @attended_events = @user.attended_events.where.not(user: @user).includes(:place)

    @hosted_events = get_events_by_date(@hosted_events, params[:date])
    @attended_events = get_events_by_date(@attended_events, params[:date])
  end

  def quit_event
    @event = Event.find(params[:event_id])
    if @event.user == current_user
      @event.destroy
      @event = nil
    else
      @event.event_attendees.find_by_user_id(current_user.id).destroy
    end
  end
end
