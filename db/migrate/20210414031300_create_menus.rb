class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :title, nul: false
      t.text :description
      t.string :image
      t.string :price, null: false
      t.integer :interval_min, null: false
      t.boolean :reservationable
      t.references :shop, foreign_key: true
      t.timestamps
    end
  end
end
