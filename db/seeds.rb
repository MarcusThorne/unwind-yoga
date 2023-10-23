Booking.destroy_all

User.destroy_all
User.create(name: 'Marcus', email: 'admin@admin.com', password: '123456', admin: true, confirmed_at: DateTime.current)
User.create(name: 'Marcus', email: 'user@admin.com', password: '123456', admin: false, confirmed_at: DateTime.current)
puts 'Users created'

Event.create(name: 'Yoga', description: 'Deep stretch yoga')
Event.create(name: 'Full Body', description: 'Full body workout')
Event.create(name: 'Calm Yoga', description: 'Easy going, relaxing yoga')

Review.create(name: 'Sally', description: 'Great place, nice environment, great people!')
Review.create(name: 'Lucy', description: 'Great place, nice environment, great people!')
Review.create(name: 'Sarah', description: 'Great place, nice environment, great people!')
Review.create(name: 'Amy', description: 'Great place, nice environment, great people!')
