# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# user1 = User.create(firstname: "Test", lastname: "User", email: "test@example.com", password: "password", role: "Property Seeker")

# user_detail = UserDetail.create(
#   name: "John Doe",
#   bio: "A brief bio goes here...",
#   address: "123 Main St, City, Country",
#   country: "Country Name",
#   company_name: "Example Company",
#   mobile_phone: "123-456-7890",
#   office_phone: "987-654-3210",
#   user_type: "Regular",
#   user_id: 1
# )

category1 = Category.create(name: "Apartment", parent_category: "Article")
category2 = Category.create(name: "House", parent_category: "Article")
category3 = Category.create(name: "Office", parent_category: "Article")

article1 = Article.create(
  user_id: 1,
  title: "To Buy or To Build",
  summary: "When it comes to acquiring a property, there are two main options: buying an existing property or building a new one. Both options have their own advantages and disadvantages, and the best choice depends on your specific needs and circumstances...",
  content: "The full content goes here...",
  image: "https://res.cloudinary.com/db3ckadxp/image/upload/v1710278816/pexels-pixabay-534124_ym7kf5.jpg",
  category_id: 1
)

article2 = Article.create(
  user_id: 1,
  title: "Property Listing Guide - Alveo Hive",
  summary: "Welcome to Alveo Hive, your real estate companion that is committed to putting some spark into the industry by using cutting-edge technology and innovative techniques...",
  content: "The full content goes here...",
  image: "https://res.cloudinary.com/db3ckadxp/image/upload/v1710279227/sergey-zolkin-_UeY8aTI6d0-unsplash_fjm9ih.jpg",
  category_id: 3
)

article3 = Article.create(
  user_id: 1,
  title: "Keys To Becoming A Successful Property Manager",
  summary: "Becoming a successful property manager requires a combination of skills, knowledge, and experience. Here are some tips to help you succeed in this competitive industry...",
  content: "The full content goes here...",
  image: "https://res.cloudinary.com/db3ckadxp/image/upload/v1710279112/pexels-pixabay-460695_umoeq0.jpg",
  category_id: 2
)

article4 = Article.create(
  user_id: 1,
  title: "The Future of Real Estate",
  summary: "The real estate industry is constantly evolving, and it is important to stay ahead of the curve. Here are some trends that are shaping the future of real estate...",
  content: "The full content goes here...",
  image: "https://res.cloudinary.com/db3ckadxp/image/upload/v1710279356/pexels-sevenstorm-juhaszimrus-418323_gimflz.jpg",
  category_id: 1
)

AdminUser.create!(email: 'support@alveohive.com', password: 'Hive@Alveo33', password_confirmation: 'Hive@Alveo33') if Rails.env.production?

# default currency conversion rates
Currency.create(name: 'USD', conversion_rates: { 'GBP' => 0.79, 'EUR' => 0.93, 'GHS' => 14.90 })
Currency.create(name: 'GBP', conversion_rates: { 'USD' => 1.27, 'EUR' => 1.18, 'GHS' => 18.96 })
Currency.create(name: 'EUR', conversion_rates: { 'USD' => 1.08, 'GBP' => 0.85, 'GHS' => 16.10 })
Currency.create(name: 'GHS', conversion_rates: { 'USD' => 0.067, 'GBP' => 0.053, 'EUR' => 0.062 })
