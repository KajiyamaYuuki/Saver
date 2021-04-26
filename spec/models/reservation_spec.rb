require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    @user = FactoryBot.create(:user)
    owner = FactoryBot.create(:owner)
    shop = FactoryBot.create(:shop, user: owner)
    @menu = FactoryBot.create(:menu, shop: shop)
  end
  it "バリデーションに通る" do
    reservation = Reservation.new(
      start_scheduled_at: "002021-04-30-14:20",
      end_scheduled_at: "002021-04-30-14:20",
      user_id: @user.id,
      menu_id: @menu.id
    )
    expect(reservation).to be_valid
  end
  it "日付がなければ無効" do
    reservation = Reservation.new(
      start_scheduled_at: nil,
      start_scheduled_at: nil,
      user_id: @user.id,
      menu_id: @menu.id
    )
    reservation.valid?
    expect(reservation.errors[:start_scheduled_at]).to include("を入力してください")
    expect(reservation.errors[:end_scheduled_at]).to include("を入力してください")
  end
  it "外部キーがなければ無効" do
    reservation = Reservation.new(
      start_scheduled_at: "002021-04-30-14:20",
      start_scheduled_at: "002021-04-30-14:20",
      user_id: nil,
      menu_id: nil
    )
    reservation.valid?
    expect(reservation.errors[:user]).to include("を入力してください")
    expect(reservation.errors[:menu]).to include("を入力してください")
  end
end
