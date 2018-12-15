class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.references :hotel, foreign_key: true
      t.string :photo
      t.integer :bed_one
      t.integer :bed_two
      t.string :number

      t.timestamps
    end
  end
end
