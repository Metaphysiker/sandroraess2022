class AddEmployeeGlobalEmployeeIdToWorkTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :work_times, :employee_global_employee_id, :string, default: ""
  end
end
