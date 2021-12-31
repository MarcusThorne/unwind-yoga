class AddColumnsToBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :session, index: true
    add_reference :bookings, :user, index: true
  end
end
