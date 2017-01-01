json.(event, :id, :sport_name, :user_id, :characteristic_of_user, :start_at, :end_at)
json.attendees_count event.event_attendees.size unless event.new_record?
