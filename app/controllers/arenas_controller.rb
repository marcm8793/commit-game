class ArenasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_arena, only: [:show]
  before_action :set_selected_player, only: [:show]
  before_action :set_total_weeks_and_current_week, only: [:show]

  def index
    @created_arenas = current_user.arenas
    @joined_arenas = Arena.joins(:arena_players).where(arena_players: { user_id: current_user.id }).distinct
    @arenas = Arena.all

    if params[:name].present?
      @arenas = @arenas.where('name ILIKE ?', "%#{params[:name]}%")
    end

    if params[:language].present?
      @arenas = @arenas.joins(:language).where('language.name ILIKE ?', "%#{params[:language]}%")
    end

    if params[:start_date].present?
      @arenas = @arenas.where(start_date: params[:start_date])
    end

    if params[:prize].present?
      @arenas = @arenas.where('bid <= ?', params[:prize])
    end
  end

  def show
    @arena_players = @arena.arena_players.sort_by(&:total_score).reverse
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
    reference_date = Date.new(2024, 10, 4)
    if @arena.start_date && @arena.end_date
      @total_weeks = ((@arena.end_date - @arena.start_date).to_i / 7.0).ceil
      @current_week = (( reference_date- @arena.start_date).to_i / 7) + 1
    else
      @total_weeks = 0
      @current_week = 1
    end
  end

  def arena_params
    params.require(:arena).permit(:name, :description, :start_date, :end_date, :image_url, :prize, :active, :slots, :language)
  end
end
