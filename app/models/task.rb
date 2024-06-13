class Task < ApplicationRecord
  belongs_to :arena_player

  validates :name, presence: true
  validates :description, presence: true
  validates :score, presence: true
  validates :week_number, presence: true
  validates :arena_player, presence: true
  validates :done, inclusion: { in: [true, false] }

end
