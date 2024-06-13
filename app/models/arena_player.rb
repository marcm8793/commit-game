class ArenaPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :arena

  has_many :projects
  has_many :tasks

  validate :only_one_arena_player_per_user_and_arena, on: :create

  def rank
    ranked_players = self.arena.arena_players.order(score: :desc)
    ranked_players.index(self) + 1
  end

  private

  def only_one_arena_player_per_user_and_arena
    if ArenaPlayer.exists?(user_id: user_id, arena_id: arena_id)
      errors.add(:user_id, "already has an arena player for this arena")
    end
  end
end
