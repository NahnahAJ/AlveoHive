# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(firstname: "Test", lastname: "User", email: "test@example.com", password: "password", role: "Property Seeker")

user_detail = UserDetail.create(
  name: "John Doe",
  bio: "A brief bio goes here...",
  address: "123 Main St, City, Country",
  country: "Country Name",
  company_name: "Example Company",
  mobile_phone: "123-456-7890",
  office_phone: "987-654-3210",
  user_type: "Regular",
  user_id: 1
)

category1 = Category.create(name: "Apartment", parent_category: "Article")
category2 = Category.create(name: "House", parent_category: "Article")
category3 = Category.create(name: "Office", parent_category: "Article")

article1 = Article.create(
  user_id: 1,
  title: "To Buy or To Build",
  summary: "When it comes to acquiring a property, there are two main options: buying an existing property or building a new one. Both options have their own advantages and disadvantages, and the best choice depends on your specific needs and circumstances...",
  content: "The full content goes here...",
  image: "https://www.alveohive.com/uploads/image/pexels-kindel-media-7578884.jpg?v=20190417",
  category_id: 1
)

article2 = Article.create(
  user_id: 1,
  title: "Property Listing Guide - Alveo Hive",
  summary: "Welcome to Alveo Hive, your real estate companion that is committed to putting some spark into the industry by using cutting-edge technology and innovative techniques...",
  content: "The full content goes here...",
  image: "https://www.alveohive.com/uploads/image/sergey-zolkin-_uey8ati6d0-unsplash.jpg?v=20190417",
  category_id: 3
)

article3 = Article.create(
  user_id: 1,
  title: "Keys To Becoming A Successful Property Manager",
  summary: "Becoming a successful property manager requires a combination of skills, knowledge, and experience. Here are some tips to help you succeed in this competitive industry...",
  content: "The full content goes here...",
  image: "https://www.alveohive.com/uploads/image/mission-bg.jpg?v=20190417",
  category_id: 2
)

article4 = Article.create(
  user_id: 1,
  title: "The Future of Real Estate",
  summary: "The real estate industry is constantly evolving, and it is important to stay ahead of the curve. Here are some trends that are shaping the future of real estate...",
  content: "The full content goes here...",
  image: "https://www.alveohive.com/uploads/image/page-title-background.jpg?v=20190417",
  category_id: 1
)


# default currency conversion rates
Currency.create(name: 'USD', conversion_rates: { 'GBP' => 1.22, 'EUR' => 0.95, 'GHS' => 11.78 })
Currency.create(name: 'GBP', conversion_rates: { 'USD' => 0.82, 'EUR' => 1.15, 'GHS' => 14.33 })
Currency.create(name: 'EUR', conversion_rates: { 'USD' => 1.16, 'GBP' => 0.87, 'GHS' => 12.44 })
Currency.create(name: 'GHS', conversion_rates: { 'USD' => 0.085, 'GBP' => 0.070, 'EUR' => 0.080 })
