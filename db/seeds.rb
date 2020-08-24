# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'httparty'

# User.create(username: "Testie", password: "test")
# User.create(username: "practice", password: "practice")
# User.create(username: "dog", password: "cat")

cities = ["Tokyo", "New York City", "San Francisco", "Los Angeles", "Paris", "London","Sydney", "Buenos Aires", "Cape Town","Rome"]

cities.each do |c|
  results = HTTParty.get("https://api.foursquare.com/v2/venues/explore?near=#{c}&query=&client_id=CLEV0SVE4QAHHRBL4JAAVYNQ1UVMEBBM1VX3GEKF0V4W2HDV&limit=10&client_secret=TI4DZ2Y34A5CZKICHQTE0BLB3KM5XP2CJYCXQRN34OGG2THS&v=20200624",
                         headers:{
                             "Accept-Language":"en-US,en;q=0.5" #foursquare uses this to provide English-language results
                         }
  ).parsed_response()['response']['groups'][0]['items'].map do |i|
    {
        name: i['venue']['name'],
        location: c,
        address: i['venue']['location']['formattedAddress'].join("\n")
    }
  end

  results.each do |r|
    p r
    Activity.create(r)
  end
end



