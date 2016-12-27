class Api::UsersController < Api::BaseController
  before_action :authenticate_user!

  def show
    @user = current_user
    @hosted_events = @user.events
    @attended_events = @user.attended_events
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      render json: { user: @user }
    else
      render json: { errors: @user.errors.full_messages, :needed => { email: "string", password: "string"} }, status: 402
    end
  end
end
