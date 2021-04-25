require 'rails_helper'

RSpec.describe Menu, type: :system do
  let(:owner) { create :owner }
  describe 'Menu CRUD' do
    before do
      FactoryBot.create(:shop, user: owner)
      login(owner)
    end
    describe 'Menuを新しく登録する' do
      describe 'Menu新規登録' do
        context 'フォームの入力値が正常' do
          it 'Menuの新規登録が成功' do
            visit new_menu_path
            fill_in 'shop-menu-title', with: 'オイル交換'
            fill_in 'shop-menu-price', with: '3,000'
            fill_in 'shop-menu-interval_hour', with: '0.5'
            check 'shop-menu-reservationable'
            click_button 'shop-menu-submit'
            expect(current_path).to eq shop_path(owner.shop.id)
            expect(page).to have_content 'オイル交換'
          end
        end
        context 'フォームの入力値が不正' do
          it 'Menuの新規登録が失敗' do
            visit new_menu_path
            fill_in 'shop-menu-title', with: nil
            fill_in 'shop-menu-price', with: nil
            fill_in 'shop-menu-interval_hour', with: '0.5'
            click_button 'shop-menu-submit'
            expect(current_path).to eq menus_path
            expect(page).to have_content 'メニュー名を入力してください'
            expect(page).to have_content '価格を入力してください'
            expect(page).to have_content '予約可否を入力してください'
          end
        end
      end
    end
  end
end
