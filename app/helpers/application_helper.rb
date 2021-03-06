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

  def get_events_by_date(events, date)
    return [] unless events
    case date
      when 'day_after'
        events.map {|e| e if (e.start_at >= (Date.today + 2).beginning_of_day && e.start_at <= (Date.today + 2).end_of_day) }.compact
      when 'tomorrow'
        events.map {|e| e if (e.start_at >= (Date.today + 1).beginning_of_day && e.start_at <= (Date.today + 1).end_of_day) }.compact
      else 
        events.map {|e| e if (e.start_at >= Time.now && e.start_at <= Date.today.end_of_day) }.compact
    end
  end
end
