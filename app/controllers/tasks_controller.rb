class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, except: [:create, :new]

  def create
    @task = @list.tasks.create(task_params)
    if @task.save
      redirect_to @list, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def new
    @task = @list.tasks.new
  end

  def destroy
    @task.destroy
    redirect_to @list
  end

  def delete
    @task.update_attributes(deleted_at: Time.now)
    redirect_to @list, :notice => 'Task was successfully destroyed.'
  end

  def complete
    @task.update_attribute(:completed_at, Time.now)
    redirect_to @list #, notice: "Task completed"
  end

  private

  def set_list
      @list = List.find(params[:list_id])
  end

  def set_task
      @task = @list.tasks.unscoped.find(params[:id])
  end

  def task_params
      params[:task].permit(:name, :priority)
  end
end
