require 'rails_helper'

RSpec.describe Staff, type: :system do
  let(:owner) { create :owner }
  let(:shop) { create :shop, user: owner }
  describe 'Staff CRUD' do
    describe 'staffが未登録' do
      before do
        FactoryBot.create(:shop, user: owner)
        login(owner)
      end
      describe 'staff新規登録' do
        context 'フォームの入力値が正常' do
          it 'staffの新規登録が成功' do
            visit new_staff_path
            fill_in 'shop-staff-name', with: 'kajiyama'
            fill_in 'shop-staff-role', with: 'オーナー'
            choose 'shop-staff-sex-man'
            fill_in 'shop-staff-work_history', with: '0.5'
            fill_in 'shop-staff-description', with: 'kajiyamaの紹介文'
            click_button 'shop-staff-submit'
            expect(current_path).to eq shop_path(owner.shop.id)
            click_link 'staff-tab'
            expect(page).to have_content 'kajiyama'
          end
        end
        context 'フォームの入力値が不正' do
          it 'staffの新規登録が失敗' do
            visit new_staff_path
            fill_in 'shop-staff-name', with: 'kajiyama'
            fill_in 'shop-staff-role', with: 'オーナー'
            fill_in 'shop-staff-work_history', with: '0.5'
            fill_in 'shop-staff-description', with: 'kajiyamaの紹介文'
            click_button 'shop-staff-submit'
            expect(current_path).to eq staffs_path
            expect(page).to have_content '性別を入力してください'
          end
        end
      end
    end
    describe 'staffが登録済み' do
      before do
        FactoryBot.create(:staff, shop: shop)
        login(owner)
      end
      describe 'staff編集' do
        context 'フォームの入力値が正常' do
          it 'staffの内容編集が成功' do
            visit shop_path(owner.shop.id)
            click_link 'staff-tab'
            click_link 'shop-show-edit-staff'
            fill_in 'shop-staff-name', with: 'kajiyama'
            fill_in 'shop-staff-role', with: 'オーナー'
            choose 'shop-staff-sex-man'
            fill_in 'shop-staff-work_history', with: '0.5'
            fill_in 'shop-staff-description', with: 'kajiyamaの紹介文'
            click_button 'shop-staff-submit'
            expect(current_path).to eq shop_path(owner.shop.id)
            click_link 'staff-tab'
            expect(page).to have_content 'kajiyama'
          end
        end
        context 'フォームの入力値が不正' do
          it 'staffの内容編集が失敗' do
            visit shop_path(owner.shop.id)
            click_link 'staff-tab'
            click_link 'shop-show-edit-staff'
            fill_in 'shop-staff-name', with: nil
            fill_in 'shop-staff-role', with: nil
            choose 'shop-staff-sex-man'
            fill_in 'shop-staff-work_history', with: '0.5'
            fill_in 'shop-staff-description', with: 'kajiyamaの紹介文'
            click_button 'shop-staff-submit'
            expect(page).to have_content '名前を入力してください'
          end
        end
      end
      describe 'staff削除' do
        context 'shopのオーナーユーザーはstaffを削除できる' do
          it 'staffの削除が成功' do
            visit shop_path(owner.shop.id)
            click_link 'staff-tab'
            page.accept_confirm do
              click_link 'shop-show-destroy-staff'
            end
            expect(current_path).to eq shop_path(owner.shop.id)
            click_link 'staff-tab'
            expect(page).not_to have_content 'staff3'
          end
        end
      end
    end
  end
end
