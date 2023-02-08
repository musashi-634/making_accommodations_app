class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.date :date_check_in
      t.date :date_check_out
      t.integer :person_num

      t.timestamps
    end
  end
end
