require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @owner = FactoryBot.create(:owner)
  end
  it "バリデーションに通る" do
    shop = @owner.build_shop(
      name: "shop1",
      post_code: "1008111",
      prefecture_code: "13",
      address_city: "千代田区",
      address_street: "千代田1-1",
      phone_number: "090-1234-5678",
      email: "shop1@email.com",
      url: "shop1.com"
    )
    expect(shop).to be_valid
  end
  it "住所がなければ無効" do
    shop = @owner.build_shop(
      name: "shop1",
      post_code: nil,
      prefecture_code: nil,
      address_city: nil,
      address_street: nil,
      phone_number: "090-1234-5678",
      email: "shop1@email.com",
      url: "shop1.com"
    )
    shop.valid?
    expect(shop.errors[:post_code]).to include("を入力してください")
  end
  it "外部キーがなければ無効" do
    shop = Shop.new(
      name: "shop1",
      post_code: "1008111",
      prefecture_code: "13",
      address_city: "千代田区",
      address_street: "千代田1-1",
      phone_number: "090-1234-5678",
      email: "shop1@email.com",
      url: "shop1.com",
      user_id: nil
    )
    shop.valid?
    expect(shop.errors[:user]).to include("を入力してください")
  end
end
