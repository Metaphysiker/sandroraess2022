class ApiController < ApplicationController
  protect_from_forgery except: [:sync_work_time, :sync_work_times]

  def work_times
    @work_times = WorkTime.all

    render json: @work_times
  end

  def sync_work_time

    #new_work_time = WorkTime.create(work_time_params)

    work_time = WorkTime.createOrUpdate(work_time_params)

    render json: work_time
  end

  def sync_work_times

    params["_json"].each do |element|
      WorkTime.createOrUpdate(element.permit(:minutes, :content, :deleted, :globalWorkTimeId, :created_at, :updated_at, :employee_global_employee_id))
    end

    @work_times = WorkTime.where(deleted: false)

    render json: @work_times
  end

  def sync_employees

    params["_json"].each do |element|
      WorkTime.createOrUpdate(element.permit(:first_name, :last_name, :deleted, :global_employee_id, :created_at, :updated_at))
    end

    @employees = Employee.where(deleted: false)

    render json: @employees
  end

  private
  def work_time_params
    params.require(:work_time).permit(:minutes, :content, :deleted, :globalWorkTimeId, :created_at, :updated_at)
  end
end
