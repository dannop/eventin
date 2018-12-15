class CreateWorkUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :work_users do |t|
      t.references :user, foreign_key: true
      t.references :workshop, foreign_key: true

      t.timestamps
    end
  end
end
