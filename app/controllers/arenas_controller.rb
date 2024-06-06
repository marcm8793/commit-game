class ArenasController < ApplicationController
  def index
    @arenas = Arena.all
  end

  def show
    @arena = Arena.find(params[:id])
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
