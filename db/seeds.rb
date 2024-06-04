# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Supprimez tous les articles existants pour éviter les doublons
Article.delete_all

# Créez 30 articles avec des données générées par Faker
30.times do
  Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.sentence(word_count: 100, supplemental: true, random_words_to_add: 20)
  )
end

