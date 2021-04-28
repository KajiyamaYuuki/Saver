class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_reservations = @user.reservations.order('start_scheduled_at')
    if @user.shop.present?
      @shop_reservations = @user.shop.menu_reservations.order('start_scheduled_at')
    end
    @rooms = Conversation.where(recipient_id: @user.id).or(Conversation.where(sender_id: @user.id)).order(created_at: "DESC")
  end

end
