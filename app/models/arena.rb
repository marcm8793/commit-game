class Arena < ApplicationRecord
  belongs_to :user

  has_many :arena_players
  has_many :users, through: :arena_players

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true

end
