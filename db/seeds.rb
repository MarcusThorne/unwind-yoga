Booking.destroy_all

User.destroy_all
User.create(name: 'Ashley', email: 'admin@calmnus.com', password: 'calmnusiscool', admin: true, confirmed_at: DateTime.current)
User.create(name: 'Nathan', email: 'user@calmnus.com', password: 'calmnusiscool', admin: false, confirmed_at: DateTime.current)
puts 'Users created'