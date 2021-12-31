Booking.destroy_all

User.destroy_all
User.create(name: 'Marcus', email: 'admin@admin.com', password: '123456', admin: true, confirmed_at: DateTime.current)
User.create(name: 'Marcus', email: 'user@admin.com', password: '123456', admin: false, confirmed_at: DateTime.current)
puts 'Users created'
