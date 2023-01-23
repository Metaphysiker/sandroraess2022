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
      #new_work_time = WorkTime.new(element.permit(:minutes, :content, :deleted, :globalWorkTimeId, :created_at, :updated_at))
      #new_work_time.save
      WorkTime.createOrUpdate(element.permit(:minutes, :content, :deleted, :globalWorkTimeId, :created_at, :updated_at))
    end

    @work_times = WorkTime.where(deleted: false)

    render json: @work_times
  end

  private
  def work_time_params
    params.require(:work_time).permit(:minutes, :content, :deleted, :globalWorkTimeId, :created_at, :updated_at)
  end
end
