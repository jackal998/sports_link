json.place do
  json.partial! '/api/templates/place', place: place
  json.events @events do |event|
    json.partial! '/api/templates/event', event: event
    json.attended @attended_events.include?(event)
  end
end