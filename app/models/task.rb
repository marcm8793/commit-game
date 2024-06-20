#TODO: Update this file to update the task status in real time
class Task < ApplicationRecord
  belongs_to :arena_player, touch: true

  validates :name, presence: true
  validates :description, presence: true
  validates :score, presence: true
  validates :week_number, presence: true
  validates :arena_player, presence: true
  validates :done, inclusion: { in: [true, false] }

  after_update_commit :broadcast_task
  # after_update_commit -> { broadcast_replace_later_to "tasks", partial: "tasks/task", locals: { task: self } }
  # after_update_commit -> { broadcast_replace_later_to "tasks", target: self, partial: "tasks/task", locals: { task: self } }
  # after_update_commit -> { broadcast_replace_later_to "tasks", target: "task_#{id}", partial: "tasks/task", locals: { task: self } }
  # after_update_commit -> { render turbo_stream: turbo_stream.replace("task_#{id}", partial: "tasks/task", locals: { task: self }) }

  private

  def broadcast_task
    ActionCable.server.broadcast("tasks", { task: self, done: self.done})
  end

  # def broadcast_task
  #   if saved_change_to_done?
  #     ActionCable.server.broadcast("tasks", {task: { id: id, done: done }})
  #   end
  # end
end
