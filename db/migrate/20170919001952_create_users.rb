class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :cpf
      t.string :job
      t.date :birth
      t.boolean :gender
      t.boolean :payment_status
      t.references :ej, foreign_key: true
      t.references :room, foreign_key: true
      t.string :photo
      t.boolean :adm

      t.timestamps
    end
  end
end