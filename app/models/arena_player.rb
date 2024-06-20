class ArenaPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :arena

  has_many :projects
  has_many :tasks


  def total_score
    tasks.where(done: true).sum(:score)
  end

  def rank
    ranked_players = self.arena.arena_players.sort_by(&:total_score).reverse
    ranked_players.index(self) + 1
  end

end
