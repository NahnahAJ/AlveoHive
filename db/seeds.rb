# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_detail = UserDetail.create(
  name: "John Doe",
  bio: "A brief bio goes here...",
  role: "Developer",
  address: "123 Main St, City, Country",
  country: "Country Name",
  profile_picture: "profile.jpg",
  company_name: "Example Company",
  mobile_phone: "123-456-7890",
  office_phone: "987-654-3210",
  user_type: "Regular",
  user_id: user1.id
)
