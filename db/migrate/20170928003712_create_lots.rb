class CreateLots < ActiveRecord::Migration[5.1]
  def change
    create_table :lots do |t|
      t.datetime :close_date
      t.datetime :open_date
      t.boolean :purchasable
      t.decimal :price
      t.integer :ticket_current
      t.integer :ticket_total
      t.decimal :room_with
      t.boolean :room_check
      t.references :event, foreign_key: true
      
      t.timestamps
    end
  end
end
