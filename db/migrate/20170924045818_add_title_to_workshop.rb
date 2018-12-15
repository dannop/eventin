class AddTitleToWorkshop < ActiveRecord::Migration[5.1]
  def change
    add_column :workshops, :title, :string
  end
end
