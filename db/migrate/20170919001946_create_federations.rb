class CreateFederations < ActiveRecord::Migration[5.1]
  def change
    create_table :federations do |t|
      t.string :name
      t.string :state
      t.string :icon
      t.integer :members, default: 0

      t.timestamps
    end
  end
end
