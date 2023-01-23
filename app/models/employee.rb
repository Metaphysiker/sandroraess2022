class Employee < ApplicationRecord

  def self.createOrUpdate(employee_params)
    #check if work time exists

    employees_with_global_employee_ids = Employee.where(globalEmployeeId: employee_params["global_employee_id"])
    employee = nil

    if employees_with_global_employee_ids.empty?
      employee = Employee.create(employee_params)
    elsif employees_with_global_employee_ids.count == 1
      employee = employees_with_global_employee_ids.first

      if employee.updated_at < employee_params["updated_at"].to_datetime
        employee.update(employee_params)
      end

    else
      employee = employees_with_global_employee_ids.first

      employee_ids = employees_with_global_employee_ids.pluck(:id)

      employee_ids_to_be_deleted = employee_ids - [employee.id]

      Employee.where(id: employee_ids_to_be_deleted).delete_all

      if employee.updated_at < employee_params["updated_at"].to_datetime
        employee.update(employee_params)
      end

    end

    return employee
  end

end
