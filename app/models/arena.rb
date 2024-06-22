class Arena < ApplicationRecord
  belongs_to :user

  has_one :chatroom, dependent: :destroy

  has_many :arena_players
  has_many :users, through: :arena_players

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :slots, presence: true, numericality: { only_integer: true, greater_than: 0 }

  after_create :create_chatroom

  private

  def create_chatroom
    Chatroom.create(name: "Chatroom for #{self.name}", arena: self)
  end

end
