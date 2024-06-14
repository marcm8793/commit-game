class MessagesController < ApplicationController
  before_action :set_chatroom

  def create
    @message = @chatroom.messages.build(message_params)
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(@chatroom, render_to_string(partial: "message", locals: { message: @message }))
      head :ok
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_chatroom
    @arena = Arena.find(params[:arena_id])
    @chatroom = Chatroom.find_by(arena: @arena)
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
