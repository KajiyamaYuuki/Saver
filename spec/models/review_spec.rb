require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @user = FactoryBot.create(:user)
    owner = FactoryBot.create(:owner)
    @shop = FactoryBot.create(:shop, user: owner)
  end
  it "バリデーションに通る" do
    review = Review.new(
      content: "素晴らしいアプリ",
      score: "5",
      user_id: @user.id,
      shop_id: @shop.id
    )
    expect(review).to be_valid
  end
  it "点数がなければ無効" do
    review = Review.new(
      content: "素晴らしいアプリ",
      score: nil,
      user_id: @user.id,
      shop_id: @shop.id
    )
    review.valid?
    expect(review.errors[:score]).to include("を入力してください")
  end
  it "外部キーがなければ無効" do
    review = Review.new(
      content: "素晴らしいアプリ",
      score: "5",
      user_id: nil,
      shop_id: nil
    )
    review.valid?
    expect(review.errors[:user]).to include("を入力してください")
    expect(review.errors[:shop]).to include("を入力してください")
  end
end
