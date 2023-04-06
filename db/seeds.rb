# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if User.any?
  puts "\nSkip Seeding Data"
end

User.create(
  [
    { name: 'Peter John Alvarado' },
    { name: 'Marco Polo Bonifacio' },
    { name: 'Arnold Buenaventura' },
    { name: 'Christian Allan Bautista' },
    { name: 'Kristina Mendez' },
    { name: 'Gabe Hamilton' }
  ]
)

puts "Successfully seeded #{User.count} records"
