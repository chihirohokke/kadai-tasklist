class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in #追加
  before_action :correct_user, only: [:destroy] #追加
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    # 変更前:@tasks = Task.order(id: :desc).page(params[:page]).per(3)
  end
  
  def show
  end 
  
  def new
    @task = current_user.tasks.build  # form_with 用
    # 変更前:@task = Task.new
  end 
  
  def create
     @task = current_user.tasks.build(task_params)
     # 変更前:@task = Task.new(task_params)
    if @task.save
      flash[:success] = "課題が登録されました"
      redirect_to root_url #@task
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = "課題が登録されませんでした"
      render :new  #:new
    end
  end 
  
  def edit
  end 
  
  def update
    if @task.update(task_params)
      flash[:success] = "課題は更新されました"
      redirect_to @task
    else
      flash[:danger] = "課題は更新されませんでした"
      render :edit
    end  
  end 
  
  def destroy
    @task.destroy
    
    flash[:success] = "課題は削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  #下記追加項目
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to tasks_url
    end
  end
end
