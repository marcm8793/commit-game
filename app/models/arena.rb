class Arena < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  has_many :arena_players, dependent: :destroy

end
