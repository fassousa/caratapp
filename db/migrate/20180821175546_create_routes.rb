class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.references :company, foreign_key: true
      t.integer :time

      t.timestamps
    end
  end
end
