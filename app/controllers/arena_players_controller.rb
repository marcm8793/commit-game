class ArenaPlayersController < ApplicationController
  before_action :set_arena_player, only: [:show, :edit, :update, :destroy, :ranking]
  before_action :authenticate_user!

  def ranking
    @arena_player = ArenaPlayer.find(params[:id])
    players_in_arena = ArenaPlayer.where(arena_id: @arena_player.arena_id).order(score: :desc)
    rank = players_in_arena.index { |ap| ap.id == @arena_player.id } + 1

    @ranking_info = {
      arena_name: @arena_player.arena.name,
      score: @arena_player.score,
      rank: rank,
      total_players: players_in_arena.count
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_arena_player
    @arena_player = ArenaPlayer.find(params[:id])
  end

end
