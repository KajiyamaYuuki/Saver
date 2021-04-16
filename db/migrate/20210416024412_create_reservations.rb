class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :start_scheduled_at
      t.datetime :end_scheduled_at
      t.references :user, foreign_key: true
      t.references :menu, foreign_key: true
      t.references :shop, foreign_key: true
      t.timestamps
    end
  end
end
