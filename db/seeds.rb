# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Role.role_names.each do |role_name|
  Role.create(name: role_name)
end

# User.find_by_email("s.raess@me.com").roles << Role.find_by_name("admin")
