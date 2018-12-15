class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.string :photo
      t.string :name
      t.string :address
      t.text :description
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
