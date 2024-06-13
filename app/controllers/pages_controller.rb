class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    arena_player = current_user.arena_players.first
    if arena_player
      redirect_to arena_path(arena_player.arena)
    else
      redirect_to new_arena_path, alert: "You are not part of any arena. Please create a new arena."
    end
  end
end
