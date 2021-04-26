class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content, null:false
      t.integer :score, null:false
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.timestamps
    end
  end
end
