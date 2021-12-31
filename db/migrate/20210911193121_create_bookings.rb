class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :presence
      t.string :payment_intent
      t.string :payment_method
      t.integer :attendees

      t.timestamps
    end
  end
end
