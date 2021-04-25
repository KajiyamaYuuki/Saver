require 'rails_helper'

RSpec.describe Reservation, type: :system do
  let(:user) { create :user }
  let(:owner) { create :owner }
  let(:shop) { create :shop, user: owner }
  describe 'userとshopオーナーとのメッセージのやりとり' do
    before do
      FactoryBot.create(:shop, user: owner)
      login(user)
    end
    context 'userからshopオーナーに問い合わせのメッセージを送る' do
      it 'shopページのcontactタブからメッセージ送信へ' do
        visit shop_path(owner.shop.id)
        click_link 'contact-tab'
        click_link 'shop-show-start-message'
        fill_in "message-index-body", with: "はじめまして"
        click_button "message-index-submit"
        expect(page).to have_content '未読'
      end
    end
  end
end
