json.user do
  json.(@user, :id, :fb_name, :nickname, :fb_avatar, :email, :nickname)
  json.auth_token @user.authentication_token
  json.hosted_events do
    json.array! @hosted_events do |he|
      json.(he, :id, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at)
      json.place_id he.place.place_id
    end
  end
  json.attended_events do
    json.array! @attended_events do |ae|
      json.(ae, :id, :sport_name, :place_id, :user_id, :characteristic_of_user, :start_at, :end_at)
      json.place_id ae.place.place_id
    end
  end
end