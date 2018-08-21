class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :adress
      t.float :longitude
      t.float :latitude
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
