class CreateEjs < ActiveRecord::Migration[5.1]
  def change
    create_table :ejs do |t|
      t.integer :members, default: 0
      t.string :name
      t.string :college
      t.string :icon
      t.boolean :federated, default: false
      t.references :federation, foreign_key: true

      t.timestamps
    end
  end
end
