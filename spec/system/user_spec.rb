require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create :user }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            visit new_user_registration_path
            fill_in 'devise-registrations-new-name', with: 'test'
            fill_in 'devise-registrations-new-email', with: 'test@example.com'
            fill_in 'devise-registrations-new-password', with: 'password'
            fill_in 'devise-registrations-new-password_confirmation', with: 'password'
            click_button 'devise-registrations-new-sign_up'
            expect(current_path).to eq root_path
            expect(page).to have_content 'アカウント登録が完了しました'
          end
        end
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'devise-registrations-new-name', with: 'test'
            fill_in 'devise-registrations-new-email', with: nil
            fill_in 'devise-registrations-new-password', with: 'password'
            fill_in 'devise-registrations-new-password_confirmation', with: 'password'
            click_button 'devise-registrations-new-sign_up'
            expect(current_path).to eq users_path
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗する' do
            visit new_user_registration_path
            fill_in 'devise-registrations-new-name', with: 'test'
            fill_in 'devise-registrations-new-email', with: user.email
            fill_in 'devise-registrations-new-password', with: 'password'
            fill_in 'devise-registrations-new-password_confirmation', with: 'password'
            click_button 'devise-registrations-new-sign_up'
            expect(current_path).to eq users_path
            expect(page).to have_content 'メールアドレスはすでに存在します'
          end
        end
      end
    end

    describe 'ログイン後' do
      before { login(user) }
        describe 'ユーザー編集' do
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
            it 'ユーザーの編集が失敗' do
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
