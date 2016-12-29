class UsersController < ApplicationController
	def show
    @user = current_user
    @hosted_events = @user.events
    @attended_events = @user.attended_events
  end
end
