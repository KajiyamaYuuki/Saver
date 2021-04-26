require 'rails_helper'

RSpec.describe Review, type: :system do
  let(:user) { create :user }
  let(:owner) { create :owner }
  describe 'Review作成' do
    before do
      FactoryBot.create(:shop, user: owner)
      login(user)
    end
    describe 'レビューの新規登録' do
      context 'フォームの入力値が正常' do
        it 'レビュー投稿が成功', js: true do
          visit shop_path(owner.shop.id)
          click_link "shops-show-reviews"
          first('#reviews--form__ratings span:nth-child(3)').click
          fill_in "reviews-new-content", with: "最高！！"
          click_button "review-new-submit"
          expect(page).to have_content 'レビューを投稿しました'
          expect(page).to have_content '最高！！'
        end
      end
      context 'フォームの入力値が不正' do
        it '予約情報の新規登録が失敗' do
          visit shop_path(owner.shop.id)
          click_link "shops-show-reviews"
          fill_in "reviews-new-content", with: nil
          click_button "review-new-submit"
          expect(page).to have_content 'レビューの投稿に失敗しました'
        end
      end
    end
  end
end
