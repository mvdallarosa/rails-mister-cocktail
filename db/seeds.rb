# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'

Cocktail.destroy_all
Ingredient.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
list_serialized = open(url).read
list = JSON.parse(list_serialized)

puts 'Creating 100 ingredients'
list['drinks'].each do |hash|
  Ingredient.create(name: "#{hash["strIngredient1"]}")
end

puts 'Creating 12 cocktails'
array = ['love', 'rainbows', 'flowers', 'dreams', 'sunbeams', 'peace', 'vibes', 'spices']
images = ['https://images.unsplash.com/photo-1570598912132-0ba1dc952b7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80', 'https://images.unsplash.com/photo-1560179304-6fc1d8749b23?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80', 'https://images.unsplash.com/photo-1551538827-9c037cb4f32a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1001&q=80', 'https://images.unsplash.com/photo-1486428263684-28ec9e4f2584?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80', 'https://images.unsplash.com/photo-1546171753-97d7676e4602?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80', 'https://images.unsplash.com/photo-1527661591475-527312dd65f5?ixlib=rb-1.2.1&auto=format&fit=crop&w=716&q=80', 'https://images.unsplash.com/photo-1545438102-799c3991ffb2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80', 'https://images.unsplash.com/photo-1559842438-2942c907c8fe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80']
count = 1
12.times do
  file = URI.open(images.sample)
  cocktail = Cocktail.new(name: "#{Faker::Food.fruits} & #{array.sample}")
  cocktail.photo.attach(io: file, filename: "cocktail#{count}.png", content_type: 'image/png')
  count += 1
  dose = Dose.new(description: Faker::Food.measurement)
  ingredients = Ingredient.all
  dose.ingredient = ingredients.sample
  dose.save
  cocktail.doses << dose
  cocktail.save
end

puts "Finished!"

