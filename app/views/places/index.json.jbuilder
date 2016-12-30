json.search_radius params[:radius]
json.places do
  json.array! @places do |place|
    json.partial! '/api/templates/place', place: place
    json.events do
      ['today','tomorrow','day_after'].each do |date|
        json.set! date do
          @event = get_events_by_date(place.events, date).first
          if @event
            json.partial! '/api/templates/event', event: @event
          else
            json.null!
          end
        end
      end
    end
  end
end