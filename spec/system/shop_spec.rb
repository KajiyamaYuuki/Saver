require 'rails_helper'

RSpec.describe Shop, type: :system do
  let(:owner) { create :owner }
  describe 'Shop CRUD' do
    describe 'ログイン後' do
      before { login(owner) }
        describe 'ショップ新規登録' do
          context 'フォームの入力値が正常' do
            it 'ユーザーの編集が成功' do
              visit edit_user_registration_path
              fill_in 'devise-registrations-edit-email', with: 'test@example.com'
              fill_in 'devise-registrations-edit-password', with: 'testtest'
              fill_in 'devise-registrations-edit-password_confirmation', with: 'testtest'
              fill_in 'devise-registrations-edit-current_password', with: 'password'
              click_button 'devise-registrations-edit-update'
              expect(current_path).to eq user_path(user.id)
              expect(page).to have_content 'アカウント情報を変更しました'
            end
          end
          context 'パスワードが6文字未満' do
            it 'ユーザーの編集が成功' do
              visit edit_user_registration_path
              fill_in 'devise-registrations-edit-email', with: 'test@example.com'
              fill_in 'devise-registrations-edit-password', with: 'test'
              fill_in 'devise-registrations-edit-password_confirmation', with: 'test'
              fill_in 'devise-registrations-edit-current_password', with: 'password'
              click_button 'devise-registrations-edit-update'
              expect(current_path).to eq users_path
              expect(page).to have_content 'パスワードは6文字以上で入力してください'
            end
          end
        end
    end
  end
end
