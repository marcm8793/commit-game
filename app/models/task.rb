#TODO: Update this file to update the task status in real time
class Task < ApplicationRecord
  belongs_to :arena_player

  validates :name, presence: true
  validates :description, presence: true
  validates :score, presence: true
  validates :week_number, presence: true
  validates :arena_player, presence: true
  validates :done, inclusion: { in: [true, false] }

  after_update_commit -> {
    broadcast_replace_to "tasks",
                         target: "task_#{id}",
                         partial: "tasks/task",
                         locals: { task: self }
  }

end
