# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  User.create!(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Internet.password(8, 15)
  )
end
users = User.all

#Create wikis
100.times do
  Wiki.create!(
    user:     users.sample,
    title:    Faker::Lorem.word + " " + Faker::Lorem.word,
    body:     Faker::Lorem.paragraph,
    private:  false
  )
end
wikis = Wiki.all

#Generate data for Rachel
User.first.update_attributes!(
  name:     'Rachel Brandt',
  email:    'rachel.brandt@gmail.com',
  password: 'password'
)

#Generate wikis for Rachel
5.times do
  Wiki.create!(
    user:     User.first,
    title:    Faker::Lorem.word + " " + Faker::Lorem.word,
    body:     Faker::Lorem.paragraph,
    private:  false
    # created_at: Faker::Time.between(100.days.ago, Time.now, :all)
  )
end

puts "Seed finished"
puts "#{User.count} users created!"
puts "#{Wiki.count} Wikis created!"
