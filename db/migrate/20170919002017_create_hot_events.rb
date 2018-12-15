class CreateHotEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :hot_events do |t|
      t.references :hotel, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
