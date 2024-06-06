class Project < ApplicationRecord
  belongs_to :arena_player
  validates :arena_player, presence: true
  validates :repo_url, presence: true
  validates :name, presence: true
end
