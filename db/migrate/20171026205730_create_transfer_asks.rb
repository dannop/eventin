class CreateTransferAsks < ActiveRecord::Migration[5.1]
  def change
    create_table :transfer_asks do |t|
      t.integer :asker_id
      t.integer :replyer_id

      t.timestamps
    end
    add_index "transfer_asks", ["asker_id"], name: "index_transfer_asks_on_asker_id", using: :btree
    add_index "transfer_asks", ["replyer_id"], name: "index_transfer_asks_on_replyer_id", using: :btree
  end
end
