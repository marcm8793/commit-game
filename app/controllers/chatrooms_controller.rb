class ChatroomsController < ApplicationController
  before_action :set_arena

  def show
    @chatroom = @arena.chatroom
    @messages = @chatroom.messages.includes(:user)
  end

  private

  def set_arena
    @arena = Arena.find(params[:arena_id])
  end
end
