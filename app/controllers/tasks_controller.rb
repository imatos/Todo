class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy,
    :mark_as_todo, :mark_as_doing, :mark_as_done]

  before_action :authorized_user!, except: [:index, :new, :create]
  before_action :authenticate_user!

  def index
    @todo_tasks = current_user.tasks.todo
    @doing_tasks = current_user.tasks.doing
    @done_tasks = current_user.tasks.done
  end

  def new
    @task = current_user.tasks.build
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

  def mark_as_todo
    @task.todo!
    redirect_to tasks_path
  end

  def mark_as_doing
    @task.doing!
    redirect_to tasks_path
  end

  def mark_as_done
    @task.done!
    redirect_to tasks_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:content)
    end

    def authorized_user!
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to tasks_path, notice: "Not authorized to edit this task" if @task.nil?
    end
end
