# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Wine.find_or_create_by!(name: "Cheval Blanc", producer: "Saint-Emilion", year: 1983, price: 1500)
Wine.find_or_create_by!(name: "Cheval Vert", producer: "Saint-Emilion", year: 2000, price: 1000)

Expert.find_or_create_by(name: "Karl", email: "karl@powerwine.com")

Wine.find_each do |wine|
    wine.rates.find_or_create_by(expert_id: Expert.first.id) do |rate|
        rate.rate = 9
    end
end
