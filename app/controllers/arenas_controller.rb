class ArenasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_arena, only: [:show]
  before_action :set_selected_player, only: [:show]
  before_action :set_total_weeks_and_current_week, only: [:show]

  def index
    @created_arenas = current_user.arenas
    @joined_arenas = Arena.joins(:arena_players).where(arena_players: { user_id: current_user.id }).distinct
  end

  def show
    @arena_players = @arena.arena_players.order(score: :desc)
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

  def set_arena
    @arena = Arena.find(params[:id])
  end

  def set_selected_player
    @selected_player = @arena.arena_players.find(params[:player_id]) if params[:player_id].present?
  end

  def set_total_weeks_and_current_week
    if @arena.start_date && @arena.end_date
      @total_weeks = ((@arena.end_date - @arena.start_date).to_i / 7.0).ceil
      @current_week = ((Date.today - @arena.start_date).to_i / 7) + 1
    else
      @total_weeks = 0
      @current_week = 1
    end
  end

  def arena_params
    params.require(:arena).permit(:name, :description, :start_date, :end_date, :image_url, :prize, :active)
  end
end
