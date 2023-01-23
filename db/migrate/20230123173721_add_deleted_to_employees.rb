class AddDeletedToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :deleted, :boolean, default: false
  end
end
