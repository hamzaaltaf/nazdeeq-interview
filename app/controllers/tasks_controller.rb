class TasksController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :destroy, :update, :create, :new]
  before_action :authorized_user , only: [:edit, :update, :destroy]
  before_action :public_tasks, only: [:update, :index, :destroy, :create]
  before_action :set_task, only: [:update]
 
  
  def index
  
  end
  
  def new
  	@task = Task.new
  end

  def create
  	@task = current_user.tasks.create(task_params)
  end

  def show
  	@task = Task.find(params[:id])
  end

  def update
    @task.update(complete: !@task.complete)
  end

  def destroy
    @task.destroy
  end

  private
  
  def authorized_user
    @task = Task.find(params[:id])
    if current_user != @task.user
      redirect_to tasks_path
    end
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def public_tasks
    @tasks = Task.public_access.order(:id)
  end

  def task_params
  	params.require(:task).permit(:name,  :description, :privacy)
  end
end
