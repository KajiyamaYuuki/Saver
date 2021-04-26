require 'rails_helper'

RSpec.describe Reservation, type: :system do
  let(:user) { create :user }
  let(:owner) { create :owner }
  let(:shop) { create :shop, user: owner }
  describe 'Reservation作成' do
    before do
      FactoryBot.create(:menu, shop: shop)
      login(user)
    end
    describe '予約情報の新規登録' do
      context 'フォームの入力値が正常' do
        it '予約情報の新規登録が成功' do
          visit shop_path(owner.shop.id)
          click_link "shop-show-reserve-menu"
          fill_in "reservation-new-start_scheduled_at", with: "002021-04-30-14:20"
          fill_in "reservation-new-end_scheduled_at", with: "002021-04-30-14:50"
          click_button "reservation-new-submit"
          expect(current_path).to eq user_path(user.id)
          expect(page).to have_content '来店予定日時：2021/04/30 14:20:00~'
        end
      end
      context 'フォームの入力値が不正' do
        it '予約情報の新規登録が失敗' do
          visit shop_path(owner.shop.id)
          click_link "shop-show-reserve-menu"
          fill_in "reservation-new-start_scheduled_at", with: nil
          fill_in "reservation-new-end_scheduled_at", with: nil
          click_button "reservation-new-submit"
          expect(page).to have_content '予約開始時刻を入力してください'
          expect(page).to have_content '予約終了時刻を入力してください'
        end
      end
    end
  end
  describe 'Reservation削除' do
    before do
      menu = FactoryBot.create(:menu, shop: shop)
      FactoryBot.create(:reservation, menu: menu, user: user)
      login(owner)
    end
    describe '予約情報の新規登録' do
      context 'フォームの入力値が正常' do
        it '予約情報の新規登録が成功' do
          visit shop_path(owner.shop.id)
          click_link "reservation-tab"
          find(".fc-time").click
          page.accept_confirm do
            click_link 'reservation-index-destroy'
          end
          expect(page).not_to have_content '14:30 - 15:30'
        end
      end
    end
  end
end
