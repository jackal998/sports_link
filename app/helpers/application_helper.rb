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
      return Faker::Superhero.name
    end
  end
end
