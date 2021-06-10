class AddAttendeesToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :attendees, :integer
  end
end
