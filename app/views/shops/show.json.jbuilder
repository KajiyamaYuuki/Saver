json.array!(@shop.menu_reservations) do |shop_reservation|
  json.extract! shop_reservation, :id, :menu_id, :user_id
  json.start shop_reservation.start_scheduled_at
  json.end shop_reservation.end_scheduled_at
  json.url menu_reservations_path(shop_reservation.menu.id)
end
