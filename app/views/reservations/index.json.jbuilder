json.array!(@reservations) do |reservation|
  json.extract! reservation, :id
  json.start reservation.start_scheduled_at
  json.end reservation.end_scheduled_at
end
