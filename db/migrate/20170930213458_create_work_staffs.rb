class CreateWorkStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :work_staffs do |t|
      t.references :staff, foreign_key: true
      t.references :workshop, foreign_key: true

      t.timestamps
    end
  end
end
