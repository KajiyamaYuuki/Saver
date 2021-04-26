require 'rails_helper'

RSpec.describe User, type: :model do
  it "必要事項が入力されたらバリデーションに通る" do
    user = User.new(
      name: "kajiyama",
      email: "kajiyama@email.com",
      password: "kajikaji",
      is_admin: false,
      is_owner: false
    )
    expect(user).to be_valid
  end
  it "重複したメールアドレスなら無効" do
    User.create(
      name: "user1",
      email: "test@email.com",
      password: "user1test",
      is_admin: false,
      is_owner: false
    )
    user = User.new(
      name: "user2",
      email: "test@email.com",
      password: "user2test",
      is_admin: false,
      is_owner: false
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  it "ユーザー名の字数制限" do
    user = User.new(
      name: "a" * 50,
      email: "aaa@email.com",
      password: "aaaaaaaa",
      is_admin: false,
      is_owner: false
    )
    user.valid?
    expect(user.errors[:name]).to include("は30文字以内で入力してください")
  end
end
