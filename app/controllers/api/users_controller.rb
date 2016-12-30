class Api::UsersController < Api::BaseController
  before_action :authenticate_user!

  def show
    @user = current_user
    @hosted_events = @user.events.includes(:place)
    @attended_events = @user.attended_events.where.not(user: @user).includes(:place)
  end

  # def create
  #   @user = User.new(params.require(:user).permit(:email, :password))
  #   if @user.save
  #     render json: { user: @user }
  #   else
  #     render json: { errors: @user.errors.full_messages, :needed => { email: "string", password: "string"} }, status: 402
  #   end
  # end

  def quit_event
    @event = Event.find_by_id(params[:event_id])
    if @event.present?
      if @event.user == current_user
        @event.destroy
        render json: { message: "event:" + params[:event_id] + "deleted"}
      else
        @event_attendee = @event.event_attendees.find_by_user_id(current_user.id)
        if @event_attendee.present?
          @event_attendee.destroy
          render json: { message: "quit event:" + params[:event_id] }
        else
          render json: { errors: 'No event error', :needed => { event_id: "integer"} }, status: 400
        end
      end
    else
      render json: { errors: 'No event error', :needed => { event_id: "integer"} }, status: 400
    end
  end
end
