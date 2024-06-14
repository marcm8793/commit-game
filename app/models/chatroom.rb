class Chatroom < ApplicationRecord
  belongs_to :arena
  has_many :messages, dependent: :destroy
end
