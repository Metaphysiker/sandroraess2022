class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.string :global_employee_id, default: ""

      t.timestamps
    end
  end
end
