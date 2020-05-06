class PersonalMessagesController < ApplicationController
  before_action :find_conversation!

  def new
    redirect_to conversation_path(@conversation) and return if @conversation
    @personal_message = current_user.personal_messages.build
  end

  def create
    @conversation ||= Conversation.create(author_id: current_user.id, receiver_id: @receiver.id)
    @personal_message = current_user.personal_messages.build(personal_message_params)
    @personal_message.conversation_id = @conversation.id

    respond_to do |format|
      if @personal_message.save!
        ActionCable.server.broadcast('room_channel', body: @personal_message.body, sender: current_user.name)
        ActionCable.server.broadcast("notifier_#{@conversation.with(current_user).id}_channel",
                                     notification: render_notification(@personal_message),
                                     conversation_id: @personal_message.conversation.id)
        format.js
      end
    end
  end

  def show
  end

  private

  def personal_message_params
    params.require(:personal_message).permit(:body)
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
      redirect_to(root_path) and return unless @receiver
      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end

  def render_notification(message)
    NotificationsController.render partial: 'notifications/notification', locals: { message: message }
  end
end
