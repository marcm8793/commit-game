class ArenaPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :arena

  validates :only_one_arena_player_per_user, on: :create

  def only_one_arena_player_per_user
    if ArenaPlayer.exists?(user_id: user_id)
      errors.add(:user_id, "already has an arena player")
    end
  end
end
