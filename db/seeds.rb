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
  company_name: "Example Company",
  mobile_phone: "123-456-7890",
  office_phone: "987-654-3210",
  user_type: "Regular",
  user_id: 1
)

# default currency conversion rates
Currency.create(name: 'USD', conversion_rates: { 'GBP' => 1.22, 'EUR' => 0.95, 'GHS' => 11.78 })
Currency.create(name: 'GBP', conversion_rates: { 'USD' => 0.82, 'EUR' => 1.15, 'GHS' => 14.33 })
Currency.create(name: 'EUR', conversion_rates: { 'USD' => 1.16, 'GBP' => 0.87, 'GHS' => 12.44 })
Currency.create(name: 'GHS', conversion_rates: { 'USD' => 0.085, 'GBP' => 0.070, 'EUR' => 0.080 })
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?