class CreateWorkTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :work_times do |t|
      t.integer :minutes, default: 0
      t.text :content, default: ""
      t.boolean :deleted, default: false
      t.string :globalWorkTimeId, default: ""

      t.timestamps
    end
  end
end
