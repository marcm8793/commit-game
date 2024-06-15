class ArenaPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :arena

  has_many :projects
  has_many :tasks


  def rank
    ranked_players = self.arena.arena_players.order(score: :desc)
    ranked_players.index(self) + 1
  end

end
