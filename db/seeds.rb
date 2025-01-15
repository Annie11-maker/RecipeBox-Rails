# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear the database to avoid duplicates
Recipe.destroy_all
# puts "Creating recipes"

# # Create recipes
# Recipe.create!(
#   name: "Pancakes recipe",
#   description: "Fluffy, golden pancakes perfect for breakfast, topped with syrup, butter, or fresh fruits.",
#   image_url: "https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/basicpancakeswithsuga_66226_16x9.jpg",
#   rating: 4.6
# )

# Recipe.create!(
#   name: "Spaghetti Carbonara",
#   description: "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
#   image_url: "https://ichef.bbci.co.uk/food/ic/food_16x9_320/recipes/spaghettiallacarbona_73311_16x9.jpg",
#   rating: 4.6
# )

# Recipe.create!(
#   name: "Classic Margherita Pizza",
#   description: "An Italian pizza topped with fresh tomatoes, mozzarella cheese, fresh basil, and olive oil.",
#   image_url: "https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/san_marzano_tomato_pizza_17797_16x9.jpg",
#   rating: 4.7
# )

# Recipe.create!(
#   name: "Vegetable Stir Fry",
#   description: "A quick and healthy dish made with a variety of fresh vegetables stir-fried in a savory sauce.",
#   image_url: "https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/6-ingredient_chinese_13476_16x9.jpg",
#   rating: 4.5
# )
# puts "Done with #{Recipe.count} recipes!"
require 'open-uri'
require 'json'

puts "Creating Recipes..."
categories = ["Breakfast", "Pasta", "Seafood", "Dessert"]

def recipe_builder(id)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"

  response = URI.open(url).read
  meal = JSON.parse(response)["meals"][0]
  puts "Creating #{meal['strMeal']}"
  Recipe.create(
    name: meal["strMeal"],
    description: meal["strInstructions"],
    image_url: meal["strMealThumb"],
    rating: rand(2..5.0).floor(1)
  )
end


categories.each do |category|
  puts "Fetching recipes for category: #{category}"

  url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"

  response = URI.open(url).read
  recipes = JSON.parse(response)["meals"]

  recipes.each do |recipe|
    puts "Recipe ID: #{recipe['idMeal']}"

    recipe_builder(recipe['idMeal'])
  end
end
