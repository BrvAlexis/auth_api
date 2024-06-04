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

5.times do
    User.create!(
      
      email: Faker::Internet.email,
      password: Faker::Internet.password(min_length: 8)
    )
  end

# Utilisez les utilisateurs existants pour créer des articles
users = User.all

# Assurez-vous qu'il y a des utilisateurs disponibles
if users.any?
    users.each do |user|
      # Créez 10 articles pour chaque utilisateur
      10.times do
        article = user.articles.create!(
          title: Faker::Book.title,
          content: Faker::Lorem.sentence(word_count: 100, supplemental: true, random_words_to_add: 20)
        )
  
        # Ajoutez des commentaires aux articles
        3.times do
          article.comments.create!(
            commenter: Faker::Name.name,
            body: Faker::Lorem.sentence(word_count: 20)
          )
        end
      end
    end
  else
    puts 'Aucun utilisateur trouvé. Veuillez créer des utilisateurs avant de lancer ce seed.'
  end

