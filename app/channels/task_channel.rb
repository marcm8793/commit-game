#TODO: Update this file to update the task status in real time
class TaskChannel < ApplicationCable::Channel
  def subscribed
    p '========TaskChannel subscribed=========='
    stream_from "tasks"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
