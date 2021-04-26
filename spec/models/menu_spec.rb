require 'rails_helper'

RSpec.describe Menu, type: :model do
  before do
    owner = FactoryBot.create(:owner)
    @shop = FactoryBot.create(:shop, user: owner)
  end
  it "バリデーションに通る" do
    menu = @shop.menus.build(
      title: "menu1",
      description: "menu1の説明文です",
      price: "1,000",
      interval_hour: "1",
      reservationable: "true"
    )
    expect(menu).to be_valid
  end
  it "名前がなければ無効" do
    menu = @shop.menus.build(
      title: nil,
      description: "menu1の説明文です",
      price: "1,000",
      interval_hour: "1",
      reservationable: "true"
    )
    menu.valid?
    expect(menu.errors[:title]).to include("を入力してください")
  end
  it "外部キーがなければ無効" do
    menu = Menu.new(
      title: "menu1",
      description: "menu1の説明文です",
      price: "1,000",
      interval_hour: "1",
      reservationable: "true"
    )
    menu.valid?
    expect(menu.errors[:shop]).to include("を入力してください")
  end
end
