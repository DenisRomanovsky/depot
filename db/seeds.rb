# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
#

Product.create(title: "PS 3", description: "Play Station 3, new and with 5 games in the box! WERTYUIOP{}SDFGHJKL:ZXCVBNM<>?", image_url: "ruby.jpg", price: 43.15)
Product.create(title: "PS 4",
 description: %{<p>Play Station 4, new and with 10 games in the box! WERTYUIOP{}SDFGHJKL:ZXCVBNM<>? </p>},
  image_url: "rtp.jpg",
  price: 43.15)
Product.create(title: "iPhone6",
 description: %{<p> Womanizer number 1! Brand new iPhone 6. Cool and black as death. All da beathces gonna be yours, dude! Take it an your life will change once and for all! </p>},
  image_url: "rails.jpg",
  price: 43.15)
