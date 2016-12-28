class UsersController < ApplicationController
	def show
    @user = current_user
    @hosted_events = @user.events.selected
    @attended_events = @user.attended_events.selected
  end
end
