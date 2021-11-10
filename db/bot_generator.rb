# # zipcodes
# puts "importing zip codes..."
# filedata = File.open("./db/zipcodelist.csv").readlines.map(&:chomp)
# filedata = filedata.drop(1)
# filedata.each { |line_of_data|
#   array = line_of_data.split(",")
#   Location.create!(zipcode: array[0], latitude: array[1].to_f, longitude: array[2].to_f)
#   puts "#{array}...done!"
# }
# puts "importing zip codes...done!"

# #new users
# puts "generating base users"
# User.create!(email: "dave@gmail.com", password: "password", first_name: "Dave", zipcode: "60067", latitude: Location.find_by(zipcode: "60067").latitude, longitude: Location.find_by(zipcode: "60067").longitude, profile_picture: "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/1/6/1671013a-2c15-44f0-b4bc-057eb5f727db.jpg?1562701916", age: 32, about_me: "Hi, looking for a group to practice some standard deck or play arena")
# puts "..."
# User.create!(email: "test@test.com", password: "password", first_name: "Jack", zipcode: "60007", latitude: Location.find_by(zipcode: "60067").latitude, longitude: Location.find_by(zipcode: "60067").longitude, profile_picture: "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/5/a/5adcb500-8c77-4925-8e2c-1243502827d1.jpg?1604243976", age: 25, about_me: "Just about_me: looking for a store that plays legacy, anyone know?")
# puts "..."
# User.create!(email: "joe@test.com", password: "password", first_name: "Joe", zipcode: "60188", latitude: Location.find_by(zipcode: "60188").latitude, longitude: Location.find_by(zipcode: "60188").longitude, profile_picture: "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/c/d/cd1deda0-c99d-4570-a5dd-f51eb5d12570.jpg?1562267420", age: 29, about_me: "What is this thing??")
# puts "..."
# User.create!(email: "bob@test.com", password: "password", first_name: "Michelle", zipcode: "60067", latitude: Location.find_by(zipcode: "60067").latitude, longitude: Location.find_by(zipcode: "60067").longitude, profile_picture: "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/6/5/65b7275a-5305-42e6-b5c3-8b88568b4e28.jpg?1562819184", age: 21, about_me: "Hey what's up guys")
# puts "..."
# puts "generating base users...done!"

#bot factory
puts "generating bots..."
50.times do
  location = nil
  while location == nil
    location = Location.find_by(id: rand(29843..30104))
    if location == nil
      puts "failed to find location, trying again"
    end
  end

  # double sided cards actually have two art crops, and so the response is an array, which messes up the seed.
  #  This just searches for another card instead.
  scryfall_art_crop = nil
  while scryfall_art_crop == nil
    scryfall_art_crop = HTTP.get("https://api.scryfall.com/cards/random").parse()
    if scryfall_art_crop["image_uris"]
      scryfall_art_crop = scryfall_art_crop["image_uris"]["art_crop"]
    else
      scryfall_art_crop = nil
    end
    sleep(1)
  end
  sleep(1)
  bot = User.new(password: "password", first_name: Faker::Name.first_name, zipcode: location.zipcode, latitude: location.latitude, longitude: location.longitude, profile_picture: scryfall_art_crop, age: rand(21..39))
  bot.email = Faker::Internet.unique.email(name: "#{bot.first_name}")
  bot.about_me = "Hi! I'm a bot named #{bot.first_name}. My favorite album is #{Faker::Music.album}. #{Faker::TvShows::Simpsons.quote}"
  bot.save
  Favoriteformat.create!(format: "Commander / EDH", user_id: bot.id)
  puts "bot #{bot.first_name} has been created"
end
puts "generating bots...done!"

# #their formats
# puts "generating favorite formats..."
# User.all.each { |user|
#   formats = ["Commander / EDH",
#              "Standard",
#              "Cube / Draft",
#              "Modern",
#              "Pauper",
#              "Pioneer",
#              "Brawl",
#              "Historic",
#              "Legacy",
#              "Vintage"]
#   repetition = rand(1..5)
#   repetition.times do
#     sliced = formats.sample
#     formats.delete(sliced)
#     Favoriteformat.create!(format: sliced, user_id: user.id)
#   end
# }
# puts "generating favorite formats...done!"

# #their relationships
# puts "generating relationships...done!"
# Relationship.create!(requester_id: 1, responder_id: 2, status: "Accepted")
# Relationship.create!(requester_id: 1, responder_id: 3, status: "Accepted")
# Relationship.create!(requester_id: 1, responder_id: 10, status: "Accepted")
# Relationship.create!(requester_id: 1, responder_id: 12, status: "Accepted")
# Relationship.create!(requester_id: 6, responder_id: 1, status: "Accepted")
# Relationship.create!(requester_id: 7, responder_id: 1, status: "Pending")
# Relationship.create!(requester_id: 9, responder_id: 1, status: "Blocked")
# Relationship.create!(requester_id: 4, responder_id: 1, status: "Pending")
# Relationship.create!(requester_id: 30, responder_id: 1, status: "Pending")
# Relationship.create!(requester_id: 20, responder_id: 1, status: "Pending")
# puts "generating relationships...done!"

# #their messages
# puts "generating messages...done!"
# Message.create!(sender_id: 1, receiver_id: 2, text: "hi jack")
# Message.create!(sender_id: 2, receiver_id: 1, text: "what's up?")
# Message.create!(sender_id: 1, receiver_id: 2, text: "do you play cube?")
# Message.create!(sender_id: 2, receiver_id: 1, text: "I've never tried it, but i'd be willing to play")
# Message.create!(sender_id: 1, receiver_id: 2, text: "Cool! Let's play on Friday at <insert local game store>")
# Message.create!(sender_id: 2, receiver_id: 1, text: "ok")
# Message.create!(sender_id: 3, receiver_id: 1, text: "hey")
# puts "generating messages...done!"
# puts "!!seeding completed!!"