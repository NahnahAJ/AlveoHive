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

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


# default currency conversion rates
Currency.create(name: 'USD', conversion_rates: { 'GBP' => 1.22, 'EUR' => 0.95, 'GHS' => 11.78 })
Currency.create(name: 'GBP', conversion_rates: { 'USD' => 0.82, 'EUR' => 1.15, 'GHS' => 14.33 })
Currency.create(name: 'EUR', conversion_rates: { 'USD' => 1.16, 'GBP' => 0.87, 'GHS' => 12.44 })
Currency.create(name: 'GHS', conversion_rates: { 'USD' => 0.085, 'GBP' => 0.070, 'EUR' => 0.080 })



# #  Seed for properties which are for sale, to assign the proper user id values after creating the users.

# # FOR SALE 1 (HOUSE)
# property1 = Property.create!(
#   user_id: 2,
#   name: "Plush 5 bedroom house",
#   location: "Kingsby Street, Ghana",
#   property_status: "For Sale",
#   property_overview: "This five bedroom house located at Achimota Kinsby is going for an affordable price. Contact me immediately to schedule a tour.",
#   number_of_bedrooms: 5,
#   number_of_bathrooms: 3,
#   ratings: 4.5,
#   furnishing: "Fully furnished",
#   price: 900000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.623522599999999,
#   longitude: -0.2409374,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "House",
#   commercial_property_type: nil
# )
# PropertyDetail.create!(
#   property_id: property1.id,
#   has_room_serviced: false,
#   number_of_storeys: 2,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: nil,
#   year_built: "2019",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil,
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: false,
#   ceiling_type: "T&J"
# )
# PublicFacility.create!(
#   property_id: property1.id,
#   schools: true,
#   hospitals: false,
#   pharmacies: true,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property1.id,
#   restaurants: true,
#   pubs: true,
#   gyms: true,
#   others: nil
# )
# property1.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property1.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property1.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property1.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property1.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')


# # FOR SALE 2 (COMMERCIAL PROPERTY)
# property3 = Property.create!(
#   user_id: 2,
#   name: "20 bedroom hotel",
#   location: "Community 25, Tema, Tema, Ghana",
#   property_status: "For Sale",
#   property_overview: "Selling this gorgeous hotel with all facilities fully-fitted. Rooms are patterned into: 2x five bedroom ensuite units, 2x four bedroom ensuite units, 1x two bedroom ensuite unit. Property has a lounge, spacious parking space, 4 workers rooms and changing room.",
#   ratings: 4.5,
#   size: 4046,
#   price: 32000000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.7273492,
#   longitude: 0.0163231,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "Commercial property",
#   commercial_property_type: "Other"
# )
# Amenity.create!(
#   property_id: property3.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: true,
#   internet_connectivity: true,
#   ac_rooms: true,
#   refridgerator: true,
#   cctv_camera: true,
#   washroom: true,
#   security_service: true,
#   tv: true,
#   gym: true,
#   walled_gated: false,
#   parking_space: false,
#   living_room: false,
#   dining_room: false,
#   waste_disposal: true,
#   others: "Helipad, Conference room, Swimming pool, Tennis court",
# )
# PropertyDetail.create!(
#   property_id: property2.id,
#   has_room_serviced: false,
#   number_of_storeys: 2,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: nil,
#   year_built: "2013",
#   street: nil,
#   payment_plan: nil,
#   state_of_land: nil,
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: nil,
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: false,
#   ceiling_type: nil
# )
# PublicFacility.create!(
#   property_id: property2.id,
#   schools: false,
#   hospitals: false,
#   pharmacies: false,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property2.id,
#   restaurants: false,
#   pubs: false,
#   gyms: false,
#   others: nil
# )
# # property2.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# # property2.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# # property2.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# # property2.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# # property2.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 3 (LAND)
# property3 = Property.create!(
#   user_id: 2,
#   name: "Affordable land for residential use",
#   location: "Afienya, Ghana",
#   property_status: "For Sale",
#   property_overview: "Very affordable land located in a developing community with access to electricity, water and good roads. 5-minutes drive from the Afienya police station. Litigation-free and well-documented.",
#   ratings: 4.5,
#   size: 70/100,
#   price: 9500,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.795836299999999,
#   longitude: 0.0023314,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "Land",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property3.id,
#   fully_fitted_kitchen: false,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: false,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: false,
#   parking_space: false,
#   living_room: false,
#   dining_room: false,
#   waste_disposal: false,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property3.id,
#   has_room_serviced: false,
#   number_of_storeys: nil,
#   pet_friendly_compound: true,
#   compound_finishing: nil,
#   finishing: nil,
#   bathroom_type_and_location: nil,
#   year_built: nil,
#   street: nil,
#   payment_plan: nil,
#   state_of_land: "Serviced",
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: nil,
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: false,
#   ceiling_type: nil
# )
# PublicFacility.create!(
#   property_id: property3.id,
#   schools: false,
#   hospitals: false,
#   pharmacies: false,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property3.id,
#   restaurants: false,
#   pubs: false,
#   gyms: false,
#   others: nil
# )
# # property3.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# # property3.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# # property3.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# # property3.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# # property3.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 4 (HOUSE)
# property4 = Property.create!(
#   user_id: 2,
#   name: "House for sale",
#   location: "Accra - Tema Motorway, Accra, Ghana",
#   property_status: "For Sale",
#   property_overview: "An uncompleted 3-bedroom house with boys quarters at Castle Gate Estate Site B. Going for 400,000 Gh Cedis only.",
#   number_of_bedrooms: 3,
#   number_of_bathrooms: 3,
#   ratings: 4.5,
#   furnishing: "Fully furnished",
#   price: 400000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.6348604,
#   longitude: -0.1437697,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "House",
#   commercial_property_type: nil
# )
# PropertyDetail.create!(
#   property_id: property4.id,
#   has_room_serviced: false,
#   number_of_storeys: 2,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: nil,
#   year_built: "2019",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: true,
#   smoking_allowed: false,
#   tiled_areas: false,
#   ceiling_type: "T&J"
# )
# PublicFacility.create!(
#   property_id: property4.id,
#   schools: true,
#   hospitals: false,
#   pharmacies: true,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property4.id,
#   restaurants: true,
#   pubs: true,
#   gyms: true,
#   others: nil
# )
# property4.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property4.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property4.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property4.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property4.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 5 (HOUSE)
# property5 = Property.create!(
#   user_id: 2,
#   name: "Beautiful 6 Bedroom House in Trassaco",
#   location: "East Legon - Trasacco Estate Road, Madina, Ghana",
#   property_status: "For Sale",
#   property_overview: "New and spacious 6-bedroom house located in a serene environment with easy accessibility to many amenities such as schools and health facilities.",
#   number_of_bedrooms: 6,
#   number_of_bathrooms: 6,
#   ratings: 4.5,
#   furnishing: "Fully furnished",
#   price:  2592622,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.6494177,
#   longitude: -0.1315887,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "House",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property5.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: false,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: true,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: false,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property5.id,
#   has_room_serviced: false,
#   number_of_storeys: 1,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: nil,
#   year_built: "2020",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: false,
#   ceiling_type: "Concrete"
# )
# PublicFacility.create!(
#   property_id: property5.id,
#   schools: true,
#   hospitals: false,
#   pharmacies: true,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property5.id,
#   restaurants: true,
#   pubs: true,
#   gyms: true,
#   others: nil
# )
# property5.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property5.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property5.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property5.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property5.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 6 (NEW DEVELOPMENTS)
# property6 = Property.create!(
#   user_id: 2,
#   name: "3 Bedroom self compound",
#   location: "Ashongman Estates, Ghana",
#   property_status: "For Sale",
#   property_overview: "3 bedroom en-suite\nSpacious living room\nGuest washroom\nFitted wardrobe\nFitted kitchen.\nTired of renting?? Take advantage of our reduced prices and contact us for your 2 bedroom apartment now.\nMake a 50% deposit and have your unit completed in less than 2 months. Occupy it while paying the remaining. Contact us now!!!!\n\nContact 0243672688/ 020 041 2517 for more details and free viewing.",
#   number_of_bedrooms: 3,
#   number_of_bathrooms: 2,
#   ratings: 4.5,
#   furnishing: "Fully furnished",
#   price: 500000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.7062442,
#   longitude: -0.2361929,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "New developments",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property6.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: true,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: true,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: false,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property6.id,
#   has_room_serviced: false,
#   number_of_storeys: 1,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: "Personal+In building",
#   year_built: "2020",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: true,
#   ceiling_type: "Concrete"
# )
# PublicFacility.create!(
#   property_id: property6.id,
#   schools: true,
#   hospitals: false,
#   pharmacies: false,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property6.id,
#   restaurants: false,
#   pubs: false,
#   gyms: false,
#   others: nil
# )
# property6.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property6.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property6.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property6.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property6.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 7 (APARTMENTS/FLATS)
# property7 = Property.create!(
#   user_id: 2,
#   name: "Radiant 2 Bedroom Self-contained Apartment",
#   location: "Ashongman Estates, Ghana",
#   property_status: "For Sale",
#   property_overview: "3 bedroom en-suite\nSpacious living room\nGuest washroom\nFitted wardrobe\nFitted kitchen.\nTired of renting?? Take advantage of our reduced prices and contact us for your 2 bedroom apartment now.\nMake a 50% deposit and have your unit completed in less than 2 months. Occupy it while paying the remaining. Contact us now!!!!\n\nContact 0243672688/ 020 041 2517 for more details and free viewing.",
#   number_of_bedrooms: 3,
#   number_of_bathrooms: 2,
#   ratings: 4.5,
#   furnishing: "Fully furnished",
#   price: 500000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.7062442,
#   longitude: -0.2361929,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "New developments",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property7.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: true,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: true,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: false,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property7.id,
#   has_room_serviced: false,
#   number_of_storeys: 1,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: "Personal+In building",
#   year_built: "2020",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: true,
#   ceiling_type: "Concrete"
# )
# PublicFacility.create!(
#   property_id: property7.id,
#   schools: true,
#   hospitals: false,
#   pharmacies: false,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property7.id,
#   restaurants: false,
#   pubs: false,
#   gyms: false,
#   others: nil
# )
# property7.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property7.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property7.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property7.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property7.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 8 (APARTMENTS/FLATS)
# property8 = Property.create!(
#   user_id: 2,
#   name: "Radiant 2 Bedroom Self-contained Apartment",
#   location: "Abokobi Boi, Accra, Ghana",
#   property_status: "For Sale",
#   property_overview: "You have the opportunity of being the owner of one of these radiant apartment units located behind the Abokobi Presbyterian church. Secure a 2 bedroom unit and pay an off plan price of GHS 180,000.\nPay an initial deposit of 40% and the remaining within 12 months.\nFeatures:\n2 bedroom en-suite\nSpacious living room\nGuest washroom\nFitted wardrobe\nFitted kitchen.\nContact 0243672688/ 0200412517 for more details and free viewing.",
#   number_of_bedrooms: 2,
#   number_of_bathrooms: 2,
#   ratings: 4.5,
#   furnishing: "Unfurnished",
#   price: 180000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.730457899999999,
#   longitude: -0.2050078,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "New developments",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property8.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: true,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: true,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: false,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property8.id,
#   has_room_serviced: false,
#   number_of_storeys: 1,
#   pet_friendly_compound: true,
#   compound_finishing: "Tiled pavement",
#   finishing: "Modern",
#   bathroom_type_and_location: "Personal+In building",
#   year_built: "2020",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: false,
#   smoking_allowed: false,
#   tiled_areas: true,
#   ceiling_type: "Concrete"
# )
# PublicFacility.create!(
#   property_id: property8.id,
#   schools: true,
#   hospitals: true,
#   pharmacies: false,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property8.id,
#   restaurants: false,
#   pubs: false,
#   gyms: false,
#   others: nil
# )
# property8.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property8.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property8.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property8.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property8.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')



# # FOR SALE 9 (HOUSE)
# property9 = Property.create!(
#   user_id: 2,
#   name: "4 Bedroom uncompleted storey",
#   location: "Ashiyie, Ghana",
#   property_status: "For Sale",
#   property_overview: "You will love to own this property as it is situated in a very calm community. It's 80% complete, needing just a few touches which best suits the buyers taste.\nIt's going for a cool GHc320000 and VERY NEGOTIABLE. It is a great deal on a 4 bedroom house which when completed will look magnificent.
#   \nHas a master bedroom with a walk-in closet.\nEvery room has its washroom.\nP.O.P ceilings done.\nAll wiring has been done.\nHas a water store tank.\nHas a biodigester.\nDoors and windows fixed and fitted.",
#   number_of_bedrooms: 4,
#   number_of_bathrooms: 3,
#   ratings: 4.5,
#   furnishing: "Unfurnished",
#   price: 320000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.743127099999999,
#   longitude: -0.1518394,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "House",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property9.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: true,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: true,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: true,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property9.id,
#   has_room_serviced: nil,
#   number_of_storeys: 2,
#   pet_friendly_compound: true,
#   compound_finishing: "Bare",
#   finishing: nil,
#   bathroom_type_and_location: nil,
#   year_built: nil,
#   street: "Untarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: true,
#   smoking_allowed: false,
#   tiled_areas: false,
#   ceiling_type: "T&J"
# )
# PublicFacility.create!(
#   property_id: property9.id,
#   schools: true,
#   hospitals: true,
#   pharmacies: nil,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property9.id,
#   restaurants: false,
#   pubs: false,
#   gyms: false,
#   others: nil
# )
# property9.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property9.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property9.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property9.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property9.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')




# # FOR SALE 10 (HOUSE)
# property10 = Property.create!(
#   user_id: 2,
#   name: "8 bedroom house for sale at Afienya",
#   location: "Afienya, Ghana",
#   property_status: "Sold",
#   property_overview: "Fully registered land-title property by the main Dawhenya-Afienya road for sale.\nProperty is on a one(1) and half plot of land.\n2 storeys: 3 rooms downstairs and 5 rooms upstairs.\nA hall, an office area, dining hall, utility area for washing and ironing.\n2 kitchens: 1 upstairs and 1 downstairs\n2 storerooms, 4200 gallons capacity water tank, 555 gallons poly reservoir and 2.5 horsepower water pumping machine.\nGround floor is fully tiled with Italian tiles. Top floor is yet to be completed.
#   \nYou can pay 70% and pay the rest in installment.\nContact me on 0556255002 for more information.",
#   number_of_bedrooms: 8,
#   number_of_bathrooms: 7,
#   ratings: 4.5,
#   furnishing: "Unfurnished",
#   price: 500000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.795836299999999,
#   longitude: 0.0023314,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "House",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property10.id,
#   fully_fitted_kitchen: true,
#   furnishing: false,
#   standby_generator: false,
#   internet_connectivity: false,
#   ac_rooms: false,
#   refridgerator: false,
#   cctv_camera: false,
#   washroom: nil,
#   security_service: false,
#   tv: false,
#   gym: false,
#   walled_gated: true,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: nil,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property10.id,
#   has_room_serviced: nil,
#   number_of_storeys: 2,
#   pet_friendly_compound: true,
#   compound_finishing: "Bare",
#   finishing: nil,
#   bathroom_type_and_location: nil,
#   year_built: nil,
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: true,
#   smoking_allowed: nil,
#   tiled_areas: true,
#   ceiling_type: "T&J"
# )
# PublicFacility.create!(
#   property_id: property10.id,
#   schools: nil,
#   hospitals: nil,
#   pharmacies: nil,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property10.id,
#   restaurants: nil,
#   pubs: nil,
#   gyms: nil,
#   others: nil
# )
# property10.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property10.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property10.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property10.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property10.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')




# # FOR SALE 11 (HOUSE)
# property11 = Property.create!(
#   user_id: 2,
#   name: "90% Completed 3-Bedroom House @ Nsawam",
#   location: "St Martins Senior High School, Nsawam, Ghana",
#   property_status: "Sold",
#   property_overview: "Very affordable, almost completed house located at Nsawam-Adoagyiri, Near St. Martins SHS.\nDETAILS\n• 2 MASTER BEDROOMS\n• 1 OTHER ROOM\n• 1 GUEST WASHROOM\n• BIG KITCHEN\n• BURGLAR-PROOF\n• BAR\n• DINING HALL\n• SECURITY DOORS FIXED\n• BIG HALL\n• 2 BALCONIES\n**PLOT SIZE: 80/110\n**3MINS WALK AWAY FROM THE TILED ROAD.\n**CONTACT ME ON 0541182409 FOR MORE INFORMATION.\n**AGENCY TERMS AND CONDITIONS APPLY.",
#   number_of_bedrooms: 3,
#   number_of_bathrooms: 2,
#   ratings: 4.5,
#   furnishing: "Unfurnished",
#   price: 200000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.8261842,
#   longitude: -0.3631389,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "House",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property11.id,
#   fully_fitted_kitchen: true,
#   furnishing: nil,
#   standby_generator: nil,
#   internet_connectivity: nil,
#   ac_rooms: nil,
#   refridgerator: nil,
#   cctv_camera: nil,
#   washroom: true,
#   security_service: nil,
#   tv: nil,
#   gym: nil,
#   walled_gated: false,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: nil,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property11.id,
#   has_room_serviced: nil,
#   number_of_storeys: nil,
#   pet_friendly_compound: true,
#   compound_finishing: "Bare",
#   finishing: nil,
#   bathroom_type_and_location: nil,
#   year_built: nil,
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: nil,
#   smoking_allowed: nil,
#   tiled_areas: false,
#   ceiling_type: "T&J"
# )
# PublicFacility.create!(
#   property_id: property11.id,
#   schools: true,
#   hospitals: nil,
#   pharmacies: nil,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property11.id,
#   restaurants: nil,
#   pubs: nil,
#   gyms: nil,
#   others: nil
# )
# property11.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property11.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property11.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property11.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property11.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')




# # FOR SALE 12 (HOUSE)
# property12 = Property.create!(
#   user_id: 2,
#   name: "Executive Chamber and Hall Apartment",
#   location: "Pantang, Pantang West, Ghana",
#   property_status: "For Sale",
#   property_overview: "Phase one of our exclusive Executive one bedroom unit has started.\nFeatures are:\nBedroom,\nbathroom,\nspacious living room,\nwalk in closet,\nfitted kitchen,\nbalcony.\nAnd guess what it’s selling for a cool GHS 75,000. Contact us for an off plan deal now!!! Location: close to the Adenta-Pantang police station",
#   number_of_bedrooms: 1,
#   number_of_bathrooms: 1,
#   ratings: 4.5,
#   furnishing: "Unfurnished",
#   price: 75000,
#   date_listed: Date.today,
#   is_property_live: true,
#   latitude: 5.7278688,
#   longitude: -0.1961869,
#   currency: "GHS",
#   hits_count: 0,
#   property_type: "Apartments/Flats",
#   commercial_property_type: nil
# )
# Amenity.create!(
#   property_id: property12.id,
#   fully_fitted_kitchen: true,
#   furnishing: nil,
#   standby_generator: nil,
#   internet_connectivity: nil,
#   ac_rooms: nil,
#   refridgerator: nil,
#   cctv_camera: nil,
#   washroom: true,
#   security_service: nil,
#   tv: nil,
#   gym: nil,
#   walled_gated: false,
#   parking_space: true,
#   living_room: true,
#   dining_room: true,
#   waste_disposal: nil,
#   others: nil,
# )
# PropertyDetail.create!(
#   property_id: property12.id,
#   has_room_serviced: nil,
#   number_of_storeys: nil,
#   pet_friendly_compound: true,
#   compound_finishing: "Bare",
#   finishing: nil,
#   bathroom_type_and_location: nil,
#   year_built: "2020",
#   street: "Tarred",
#   payment_plan: nil,
#   state_of_land: nil, 
#   number_of_tenants: nil,
#   type_of_meter: nil,
#   source_of_water: "GWCL (pipeborne)",
#   property_needs_renovation: false,
#   smoking_allowed: nil,
#   tiled_areas: false,
#   ceiling_type: "T&J"
# )
# PublicFacility.create!(
#   property_id: property12.id,
#   schools: true,
#   hospitals: nil,
#   pharmacies: nil,
#   others: nil
#   # others: "Grocery stores, Parks"
# )
# RecreationalFacility.create!(
#   property_id: property12.id,
#   restaurants: nil,
#   pubs: nil,
#   gyms: nil,
#   others: nil
# )
# property12.images.attach(io: File.open(Rails.root.join('uploads', 'sale1.jpeg')), filename: 'sale1.jpeg')
# property12.images.attach(io: File.open(Rails.root.join('uploads', 'sale2.jpeg')), filename: 'sale2.jpeg')
# property12.images.attach(io: File.open(Rails.root.join('uploads', 'sale3.jpeg')), filename: 'sale3.jpeg')
# property12.images.attach(io: File.open(Rails.root.join('uploads', 'sale4.jpeg')), filename: 'sale4.jpeg')
# property12.images.attach(io: File.open(Rails.root.join('uploads', 'sale5.jpeg')), filename: 'sale5.jpeg')