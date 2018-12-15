class CreateLecStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :lec_staffs do |t|
      t.references :staff, foreign_key: true
      t.references :lecture, foreign_key: true

      t.timestamps
    end
  end
end
