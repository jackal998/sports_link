json.user do
  json.(@user, :id, :fb_name, :nickname, :fb_avatar, :email, :nickname)
  json.auth_token @user.authentication_token
  ['today','tomorrow','day_after'].each do |date|
    json.set! date do
      json.hosted_events do
        if @hosted_events
          json.array! get_events_by_date(@hosted_events, date) do |he|
            json.partial! '/api/templates/event', event: he
            if he
              json.place_id he.place.place_id
              json.place_name he.place.name
            end
          end
        else
          json.null!
        end
      end
      json.attended_events do
        if @attended_events
          json.array! get_events_by_date(@attended_events, date) do |ae|
            json.partial! '/api/templates/event', event: ae
            if ae
              json.place_id ae.place.place_id
              json.place_name ae.place.name
            end
          end
        else
          json.null!
        end
      end
    end
  end
end