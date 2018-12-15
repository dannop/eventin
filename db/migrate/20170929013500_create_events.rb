class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :begin_day
      t.datetime :end_day
      
      t.datetime :activity_begin_day
      t.datetime :activity_end_day
      
      t.datetime :room_begin_day
      t.datetime :room_end_day
      
      t.text :description
      
      t.timestamps
    end
  end
end
