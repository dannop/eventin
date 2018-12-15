class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts do |t|
      t.integer :ticket_id
      t.integer :lot_id
      t.integer :price
      t.string :status
      t.string :buyer_name
      t.string :reference

      t.timestamps
    end
  end
end
