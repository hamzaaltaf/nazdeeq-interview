class TasksController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :destroy, :update, :start]
  before_action :authorized_user , only: [:edit, :update, :destroy, :start]
  before_action :public_tasks, only: [:update, :index, :destroy, :create, :start]
  before_action :set_task, only: [:update, :start]
 
  
  def index
  
  end
  
  def new
  	@task = Task.new
  end

  def create
  	@task = Task.create(task_params)
  end

  def show
  	@task = Task.find(params[:id])
  end

  def sort
    @tasks = Task.where(:sprint => params[:task][:sprint])
  end

  def update
    if current_user.admin?
      user = User.find_by(email: params[:task][:assigned_to] + '@augmentcare.com')
      params[:task][:user_id]  = user.id
      @task.update(params.require(:task).permit(:dev_status,  :qa_status, :category, :assigned_to, :priority, :complete, :user_id, :caused_by))
    else
      time_taken = ((time_taken = Time.now - @task.started_at)/60).to_i
      @task.update(complete: !@task.complete, completed_at: Time.now, time_taken: time_taken)
    end
    redirect_to tasks_path
  end

  def start
    @task.update(started_at: Time.now)
  end

  def destroy
    @task.destroy
  end

  def report
    
  end

  private
  
  def authorized_user
    @task = Task.find(params[:id])
    if current_user == @task.user || current_user.admin?
    else
      redirect_to tasks_path
    end
  end

  def set_task
    if current_user.admin?
      @task = Task.find(params[:id])
    else

    @task = current_user.tasks.find(params[:id])
  end
  end

  def public_tasks
    if !current_user.nil?
      if current_user.admin
        @tasks = Task.all.order(:id)
      else
        @tasks = current_user.tasks
      end
      else
        @tasks = Task.all.order(:id)
    end
  end

  def update_params
    
  end

  def task_params
  	params.require(:task).permit(:name,  :description, :environment, :product_type, :sprint, :reported_by)
  end
end
