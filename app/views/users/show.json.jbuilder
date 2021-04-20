json.array!(@user.reservations) do |user_reservation|
  json.extract! user_reservation, :id
  json.start user_reservation.start_scheduled_at
  json.end user_reservation.end_scheduled_at
end
