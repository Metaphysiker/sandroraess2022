class WorkTime < ApplicationRecord

  def self.createOrUpdate(work_time_params)
    #check if work time exists

    work_time_params["updated_at"] = DateTime.parse(work_time_params["updated_at"])
    #work_time_params["updated_at"] = Time.at(work_time_params["updated_at"]).to_datetime
    work_times_with_global_work_time_ids = WorkTime.where(globalWorkTimeId: work_time_params["globalWorkTimeId"])
    work_time = nil

    if work_times_with_global_work_time_ids.empty?
      work_time = WorkTime.create(work_time_params)
    else

      work_time = work_times_with_global_work_time_ids.first
      if work_time.updated_at < work_time_params["updated_at"]
        work_time.update(work_time_params)
      end
    end

    return work_time
  end

end
