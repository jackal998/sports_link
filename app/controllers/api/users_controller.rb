class Api::UsersController < Api::BaseController
  before_action :authenticate_user!

  def show
    @user = current_user
    @hosted_events = @user.events.includes(:place)
    @attended_events = @user.attended_events.where.not(user: @user).includes(:place)
  end
  # .where.not(user: @user)

  # def create
  #   @user = User.new(params.require(:user).permit(:email, :password))
  #   if @user.save
  #     render json: { user: @user }
  #   else
  #     render json: { errors: @user.errors.full_messages, :needed => { email: "string", password: "string"} }, status: 402
  #   end
  # end

  def quit_event
    @event = Event.find(params[:event_id])
    if @event
      if current_user.events.find(@event)
        @event.destroy
        render json: { message: "event:" + params[:event_id] + "deleted"}
      else
        @event.event_attendees.find_by_user_id(current_user.id).destroy if current_user.attended_events.include?(@event)
        render json: { message: "quit event:" + params[:event_id] }
      end
    else
      render json: { errors: 'No event error', :needed => { event_id: "integer"} }, status: 400
    end
  end
end
