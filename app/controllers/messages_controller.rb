class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :talk_room, only: %i[ index ]
  before_action :authenticate_user!, only: [:create]


  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end
    @messages = @messages.order(:created_at)
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      respond_to do |format|
        format.html { render 'index' }
        format.js { render :errors }
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def talk_room
    if current_user.id != @conversation.sender_id && current_user.id != @conversation.recipient_id
      flash[:notice] = '権限がありません'
      redirect_to users_path
    end
  end
end
