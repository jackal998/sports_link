module ApplicationHelper
  def user_name(user)
    if current_user
      if user.fb_uid
        return user.fb_name
      end
      if user.nickname
        if user.nickname.length > 10 
          return user.nickname[0..10] + "..."
        else
          return user.nickname
        end
      else
        return user.email.split("@").first
      end
    else
      return Faker::Superhero.name + "(Guest)"
    end
  end
  def show_duration(event)
    if (event.end_at - Time.now) > (event.end_at - event.start_at)
      return '約' + ((event.end_at - event.start_at)/1.hour).round(0).to_s + '小時'
    else
      return '約' + ((event.end_at - Time.now)/1.hour).round(0).to_s + '小時'
    end
  end
end
