require 'rails_helper'

RSpec.describe Staff, type: :model do
  before do
    owner = FactoryBot.create(:owner)
    @shop = FactoryBot.create(:shop, user: owner)
  end
  it "バリデーションに通る" do
    staff = @shop.staffs.build(
      name: "staff1",
      description: "私の名前はstaff1です",
      role: "オーナー",
      sex: "man",
      work_history: "11"
    )
    expect(staff).to be_valid
  end
  it "名前がなければ無効" do
    staff = @shop.staffs.build(
      name: nil,
      description: "私の名前はstaff1です",
      role: "オーナー",
      sex: "man",
      work_history: "11"
    )
    staff.valid?
    expect(staff.errors[:name]).to include("を入力してください")
  end
  it "外部キーがなければ無効" do
    staff = Staff.new(
      name: "staff1",
      description: "私の名前はstaff1です",
      role: "オーナー",
      sex: "man",
      work_history: "11"
    )
    staff.valid?
    expect(staff.errors[:shop]).to include("を入力してください")
  end
end
