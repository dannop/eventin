class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.datetime :the_day
      t.integer :vacancies
      t.text :description
      t.references :event, foreign_key: true
      t.references :category, foreign_key: true
      
      t.timestamps
    end
  end
end
