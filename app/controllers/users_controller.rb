class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_reservations = @user.reservations.order('start_scheduled_at')
    @shop_reservations = @user.shop.menu_reservations.order('start_scheduled_at')
    if @user.is_owner?
      @rooms = Conversation.where(recipient_id: @user.id)
    else
      @rooms = Conversation.where(sender_id: @user.id)
    end
  end

end
