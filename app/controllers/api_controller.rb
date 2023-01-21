class ApiController < ApplicationController
  def work_times
    @work_times = WorkTime.all

    render json: @work_times
  end
end
