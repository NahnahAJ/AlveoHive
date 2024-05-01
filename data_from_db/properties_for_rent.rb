# create_table "properties", force: :cascade do |t|
#   t.bigint "user_id", null: false
#   t.string "name"
#   t.string "location"
#   t.string "property_status"
#   t.text "property_overview"
#   t.integer "number_of_bedrooms"
#   t.integer "number_of_bathrooms"
#   t.decimal "ratings", default: "0.0"
#   t.string "furnishing"
#   t.decimal "size"
#   t.decimal "price"
#   t.date "date_listed"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.boolean "is_property_live", default: false
#   t.integer "number_of_ratings", default: 0
#   t.float "latitude", default: 0.0
#   t.float "longitude", default: 0.0
#   t.string "currency", default: "GHS", null: false
#   t.integer "hits_count", default: 0
#   t.string "property_type"
#   t.string "commercial_property_type"
#   t.index ["currency"], name: "index_properties_on_currency"
#   t.index ["user_id"], name: "index_properties_on_user_id"
# end

# create_table "property_details", force: :cascade do |t|
#   t.bigint "property_id", null: false
#   t.boolean "has_room_serviced", default: false
#   t.integer "number_of_storeys"
#   t.boolean "pet_friendly_compound", default: false
#   t.string "compound_finishing"
#   t.string "finishing"
#   t.string "bathroom_type_and_location"
#   t.string "year_built"
#   t.string "street"
#   t.string "payment_plan"
#   t.string "state_of_land"
#   t.string "number_of_tenants"
#   t.string "type_of_meter"
#   t.string "source_of_water"
#   t.boolean "property_needs_renovation", default: false
#   t.boolean "smoking_allowed", default: false
#   t.boolean "tiled_areas", default: false
#   t.string "ceiling_type"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["property_id"], name: "index_property_details_on_property_id"
# end

Property.create(
  user_id: Belinda,
  name: "2 Bedroom Apartment For Rent",
  location: "Tse Addo",
  property_status: "For Rent",
  property_overview: "This 2-bedroom apartment is located in a serene environment in Tse Addo.
  The compound is shared among a few tenants. It has its own ECG water Compound is gated with a car parking space GH water is connected and flows 2 washrooms
  Agency Terms Apply",
  number_of_bedrooms: 2,
  number_of_bathrooms: 2,
  ratings: 0.0,
  furnishing: "Unfurnished",
  size: 0.0,
  price: 3,500.00,
  date_listed: "2024-02-21",
  is_property_live: true,
  number_of_ratings: 0,
  latitude: 0.0,
  longitude: 0.0,
  currency: "GHS",
  hits_count: 0,
  property_type: "House",
  commercial_property_type: "Apartment"
)

PropertyDetail.create(
  property_id: 1,
  has_room_serviced: true,
  number_of_storeys: 1,
  pet_friendly_compound: false,
  compound_finishing: "Tiles",
  finishing: "Tiles",
  bathroom_type_and_location: "Shared",
  year_built: "2020",
  street: "Tse Addo",
  payment_plan: "Monthly",
  state_of_land: "Registered",
  number_of_tenants: "4",
  type_of_meter: "Prepaid",
  source_of_water: "GWCL(Pipeborne)",
  property_needs_renovation: false,
  smoking_allowed: false,
  tiled_areas: true,
  ceiling_type: "Plasterboard"
)

#################################################Property2###################################################################
Property.create(
  user_id: Belinda2,
  name: "4 Bedroom House For Rent",
  location: "Odorkor",
  property_status: "For Rent",
  property_overview: "This is a beautiful 4-bedroom self-compound house going for rent in Odorkor.
  The property comes with a spacious compound and rooms
  • All bedrooms en-suite
  • Fitted kitchen Water and electricity available
  Agency Terms Apply",
  number_of_bedrooms: 4,
  number_of_bathrooms: 5,
  ratings: 0.0,
  furnishing: "Unfurnished",
  size: 0.0,
  price: 5000.00,
  date_listed: "2024-02-21",
  is_property_live: true,
  number_of_ratings: 0,
  latitude: 0.0,
  longitude: 0.0,
  currency: "GHS",
  hits_count: 0,
  property_type: "House",
  commercial_property_type: "Apartment"
)

PropertyDetail.create(
  property_id: 2,
  has_room_serviced: true,
  number_of_storeys: 0,
  pet_friendly_compound: true,
  compound_finishing: "Tiles",
  finishing: "Tiles",
  bathroom_type_and_location: "Ensuite",
  year_built: "2020",
  street: "Odorkor",
  payment_plan: "1 year advance", 
  state_of_land: "Registered",
  number_of_tenants: "4",
  type_of_meter: "Prepaid",
  source_of_water: "GWCL(Pipeborne)",
  property_needs_renovation: false,
  smoking_allowed: false,
  tiled_areas: true,
  ceiling_type: "POP Ceiling"
)

#################################################Property3###################################################################

Property.create(
  user_id: Belinda,
  name: "2 Bedroom Apartment For Rent",
  location: "Tse Addo",
  property_status: "For Rent",
  property_overview: "This 2-bedroom apartment is located in a serene environment in Tse Addo.
  The compound is shared among a few tenants. It has its own ECG water Compound is gated with a car parking space GH water is connected and flows 2 washrooms
  Agency Terms Apply",
  number_of_bedrooms: 2,
  number_of_bathrooms: 2,
  ratings: 0.0,
  furnishing: "Unfurnished",
  size: 0.0,
  price: 3,500.00,
  date_listed: "2024-02-21",
  is_property_live: true,
  number_of_ratings: 0,
  latitude: 0.0,
  longitude: 0.0,
  currency: "GHS",
  hits_count: 0,
  property_type: "House",
  commercial_property_type: "Apartment"
)

PropertyDetail.create(
  property_id: 1,
  has_room_serviced: true,
  number_of_storeys: 1,
  pet_friendly_compound: false,
  compound_finishing: "Tiles",
  finishing: "Tiles",
  bathroom_type_and_location: "Shared",
  year_built: "2020",
  street: "Tse Addo",
  payment_plan: "Monthly",
  state_of_land: "Registered",
  number_of_tenants: "4",
  type_of_meter: "Prepaid",
  source_of_water: "GWCL(Pipeborne)",
  property_needs_renovation: false,
  smoking_allowed: false,
  tiled_areas: true,
  ceiling_type: "Plasterboard"
) 
