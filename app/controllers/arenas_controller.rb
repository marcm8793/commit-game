class ArenasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @arenas = Arena.all
  end

  def show
    @arena = Arena.find(params[:id])
    @arena_players = ArenaPlayer.where(arena_id: @arena.id).order(score: :desc)
    @selected_player = @arena_players.find(params[:player_id]) if params[:player_id].present?
  end

  def new
    @arena = Arena.new
  end

  def create
    @arena = Arena.new(arena_params)
    @arena.user = current_user
    if @arena.save
      redirect_to @arena
    else
      render :new
    end
  end

  private

  def arena_params
    params.require(:arena).permit!
  end
end
