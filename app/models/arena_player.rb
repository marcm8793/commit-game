class ArenaPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :arena
end
