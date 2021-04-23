require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

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
          end
        end
        context '登録済メールアドレス' do
        end
      end
    end

    describe 'ログイン後' do
      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
        end
        context 'メールアドレス未記入' do
        end
      end
    end
  end
end
