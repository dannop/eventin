class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :photo
      t.string :name
      t.integer :age
      t.string :job
      t.string :link_facebook
      t.string :link_instagram
      t.string :link_twitter
      t.text :description
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
