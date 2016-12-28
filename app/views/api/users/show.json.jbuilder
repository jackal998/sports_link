json.user do
  json.(@user, :id, :fb_name, :nickname, :fb_avatar, :email, :nickname)
  json.auth_token @user.authentication_token
  ['today','tomorrow','day_after'].each do |date|
    json.set! date do
      json.hosted_events do
        if @hosted_events
          json.array! @hosted_events.show_only(date) do |he|
            json.(he, :id, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at)
            json.place_id he.place.place_id if he
          end
        else
          json.null!
        end
      end
      json.attended_events do
        if @attended_events
          json.array! @attended_events.show_only(date) do |ae|
            json.(ae, :id, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at)
            json.place_id ae.place.place_id if ae
          end
        else
          json.null!
        end
      end
    end
  end
end