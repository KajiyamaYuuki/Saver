class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.text :description
      t.integer :post_code, null: false
      t.integer :prefecture_code, null: false
      t.string :address_city, null: false
      t.string :address_street, null: false
      t.string :address_building
      t.string :phone_number
      t.string :email
      t.string :url
      t.string :image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
