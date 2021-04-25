require 'rails_helper'

RSpec.describe Shop, type: :system do
  let(:owner) { create :owner }
  describe 'Shop CRUD' do
    describe 'Shopを初めて登録する' do
      before { login(owner) }
        describe 'ショップ新規登録' do
          context 'フォームの入力値が正常' do
            it 'Shopの登録が成功' do
              visit new_shop_path
              find('.shop-new-name').set('testshop')
              find('.shop-new-post_code').set('1500044')
              find('.shop-new-address_street').set('円山町28番4号')
              find('.shop-new-address_building').set('大場ビルA館')
              find('.shop-new-phone_number').set('03-5459-1808')
              find('.shop-new-email').set('testshop@email.com')
              find('.shop-new-url').set('https://diveintocode.jp')
              click_button 'shop-new-submit'
              expect(current_path).to eq shop_path(owner.shop.id)
              expect(page).to have_content 'testshop'
            end
          end
          context '必要事項の入力が不十分' do
            it 'Shopの登録が失敗' do
              visit new_shop_path
              find('.shop-new-name').set('')
              find('.shop-new-post_code').set('')
              find('.shop-new-address_street').set('')
              find('.shop-new-address_building').set('')
              find('.shop-new-phone_number').set('')
              find('.shop-new-email').set('')
              find('.shop-new-url').set('')
              click_button 'shop-new-submit'
              expect(current_path).to eq shops_path
              expect(page).to have_content '名前を入力してください'
              expect(page).to have_content '都道府県を入力してください'
            end
          end
        end
    end
    describe 'Shopが既に登録済み' do
      describe 'ショップ情報編集' do
        before do
          FactoryBot.create(:shop, user: owner)
          login(owner)
        end
          context 'フォームの入力値が正常' do
            it 'Shopの情報編集が成功' do
              visit edit_shop_path(owner.shop.id)
              find('.shop-new-name').set('testshop')
              find('.shop-new-post_code').set('1500044')
              find('.shop-new-address_street').set('円山町28番4号')
              find('.shop-new-address_building').set('大場ビルA館')
              find('.shop-new-phone_number').set('03-5459-1808')
              find('.shop-new-email').set('kajiyama@email.com')
              find('.shop-new-url').set('https://diveintocode.jp')
              click_button 'shop-new-submit'
              expect(current_path).to eq shop_path(owner.shop.id)
              expect(page).to have_content 'testshop'
            end
          end
          context 'フォームの入力値が不正' do
            it 'Shopの情報編集が失敗' do
              visit edit_shop_path(owner.shop.id)
              find('.shop-new-name').set('')
              find('.shop-new-post_code').set('')
              find('.shop-new-address_street').set('')
              find('.shop-new-address_building').set('')
              find('.shop-new-phone_number').set('')
              find('.shop-new-email').set('')
              find('.shop-new-url').set('')
              click_button 'shop-new-submit'
              expect(current_path).to eq shop_path(owner.shop.id)
              expect(page).to have_content '名前を入力してください'
            end
          end
      end
    end
  end
end
