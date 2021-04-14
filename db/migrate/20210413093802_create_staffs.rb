class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :name, null: false
      t.text :description
      t.string :image
      t.string :role, null: false
      t.integer :sex, null: false
      t.integer :work_history
      t.references :shop, foreign_key: true
      t.timestamps
    end
  end
end
