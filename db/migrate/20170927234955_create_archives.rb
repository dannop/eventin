class CreateArchives < ActiveRecord::Migration[5.1]
  def change
    create_table :archives do |t|
      t.string :name
      t.string :attachment
      t.text :description
      t.references :lecture, foreign_key: true
      t.references :workshop, foreign_key: true

      t.timestamps
    end
  end
end
