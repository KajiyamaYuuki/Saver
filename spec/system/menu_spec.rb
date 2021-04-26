require 'rails_helper'

RSpec.describe Menu, type: :system do
  let(:owner) { create :owner }
  let(:shop) { create :shop, user: owner }
  describe 'Menu CRUD' do
    describe 'Menuが未登録' do
      before do
        FactoryBot.create(:shop, user: owner)
        login(owner)
      end
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
    describe 'Menuが登録済み' do
      before do
        FactoryBot.create(:menu, shop: shop)
        login(owner)
      end
      describe 'Menu編集' do
        context 'フォームの入力値が正常' do
          it 'Menuの内容編集が成功' do
            visit shop_path(owner.shop.id)
            click_link 'shop-show-edit-menu'
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
          it 'Menuの内容編集が失敗' do
            visit shop_path(owner.shop.id)
            click_link 'shop-show-edit-menu'
            fill_in 'shop-menu-title', with: nil
            fill_in 'shop-menu-price', with: nil
            fill_in 'shop-menu-interval_hour', with: '0.5'
            check 'shop-menu-reservationable'
            click_button 'shop-menu-submit'
            expect(page).to have_content 'メニュー名を入力してください'
            expect(page).to have_content '価格を入力してください'
          end
        end
      end
      describe 'Menu削除' do
        context 'shopのオーナーユーザーはmenuを削除できる' do
          it 'Menuの削除が成功' do
            visit shop_path(owner.shop.id)
            page.accept_confirm do
              click_link 'shop-show-destroy-menu'
            end
            expect(current_path).to eq shop_path(owner.shop.id)
            expect(page).not_to have_content 'menu3'
          end
        end
      end
    end
  end
end
