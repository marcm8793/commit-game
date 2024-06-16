#TODO: Update this file to update the task status in real time
class TaskUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "task_update_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
