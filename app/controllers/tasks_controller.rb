#TODO: Update this file to update the task status in real time
class TasksController < ApplicationController
  before_action :set_arena_player, only: [:index, :show, :new, :create]

  def index
    @tasks = @arena_player.tasks
  end

  def show
    @task = @arena_player.tasks.find(params[:id])
  end

  def new
    @task = @arena_player.tasks.new
  end

  def create
    @task = @arena_player.tasks.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      end
    else
      render :edit
    end
  end

  private

  def set_arena_player
    @arena_player = ArenaPlayer.find(params[:arena_player_id])
  end

  def task_params
      params.require(:task).permit!
  end
end
