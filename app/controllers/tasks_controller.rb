class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :change_status]
  before_action :authenticate_user!

  def index
    @todo_tasks = current_user.tasks.todo
    @doing_tasks = current_user.tasks.doing
    @done_tasks = current_user.tasks.done
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new task_params

    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def change_status
    p '-' * 300
    p params[:status]
    @task.update_attributes status: params[:status]
    redirect_to tasks_path, notice: 'Task status was successfully changed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:content, :status)
    end
end
