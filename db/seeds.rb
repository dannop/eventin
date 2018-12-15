# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


1.times do
  Event.create([{
    name: Faker::LeagueOfLegends.summoner_spell,
    begin_day: Faker::Date.between(Date.today, 3.year.from_now),
    end_day: Faker::Date.between(Date.today, 3.year.from_now),
    activity_begin_day: Faker::Date.between(Date.today, 3.year.from_now),
    activity_end_day: Faker::Date.between(Date.today, 3.year.from_now),
    room_begin_day: Faker::Date.between(Date.today, 3.year.from_now),
    room_end_day: Faker::Date.between(Date.today, 3.year.from_now),
    description:Faker::Lorem.paragraph
    }])
end

5.times do
  Lot.create([{
    close_date: Faker::Date.between(Date.today, 3.year.from_now),
    open_date: Faker::Date.between(Date.today, 3.year.from_now),
    purchasable: false,
    price: rand(10..100),
    ticket_current: 100, 
    ticket_total: 100,
    room_with: rand(20..50),
    event_id: 1
    }])
end

10.times do
  Federation.create([{
    name: Faker::Pokemon.name,
    state: Faker::Pokemon.location
    }])
end

10.times do
  Ej.create([{
    name: Faker::Coffee.blend_name,
    college: Faker::HarryPotter.location,
    federation_id: Federation.find(rand(1..Federation.count)).id
    }])
end

10.times do
  Category.create([{
    kind: Faker::LeagueOfLegends.rank
    }])
end

10.times do
  Staff.create([{
  name: Faker::LeagueOfLegends.champion,
  age: rand(15..40),
  job: Faker::LeagueOfLegends.champion,
  description: Faker::Lorem.paragraph,
  event_id: 1
    }])
end

20.times do
  Hotel.create([{
  name: Faker::Address.city,
  address: Faker::Address.street_address,
  description: "descrição",
  event_id: 1
    }])
end

200.times do
  Room.create([{
  hotel_id: Hotel.find(rand(1..Hotel.count)).id,
  bed_one: rand(1..15),
  bed_two: rand(1..15),
  number: rand(1..200)
    }])
end

20.times do
  Lecture.create([{
  title: Faker::LeagueOfLegends.quote,
  the_day: Faker::Date.between(Date.today, 3.year.from_now),
  vacancies: rand(1..200),
  description:Faker::Lorem.paragraph,
  event_id: 1,
  category_id: Category.find(rand(1..Category.count)).id
    }])
end

20.times do
  Workshop.create([{
  title: Faker::Overwatch.quote,
  the_day: Faker::Date.between(Date.today, 3.year.from_now),
  vacancies: rand(1..200),
  description:Faker::Lorem.paragraph,
  event_id: 1,
  category_id: Category.find(rand(1..Category.count)).id
    }])
end

15.times do
  User.create([{
  name: Faker::DragonBall.character,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password_digest: Faker::Internet.password(8),
  cpf: rand(1..200),
  job: Faker::Job.title,
  birth: Faker::Date.birthday(18, 65),
  ej_id: Ej.find(rand(1..Ej.count)).id
    }])
end

