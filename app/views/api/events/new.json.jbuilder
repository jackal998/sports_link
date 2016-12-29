json.place do
  json.partial! '/api/templates/place', place: place
  json.event_format do
    json.partial! '/api/templates/event', event: @event
  end
end