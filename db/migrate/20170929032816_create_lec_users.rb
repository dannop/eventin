class CreateLecUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lec_users do |t|
      t.references :user, foreign_key: true
      t.references :lecture, foreign_key: true

      t.timestamps
    end
  end
end
