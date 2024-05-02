# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_24_185836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "amenities", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.boolean "fully_fitted_kitchen"
    t.boolean "furnishing"
    t.boolean "standby_generator"
    t.boolean "internet_connectivity"
    t.boolean "ac_rooms"
    t.boolean "refridgerator"
    t.boolean "cctv_camera"
    t.boolean "washroom"
    t.boolean "security_service"
    t.boolean "tv"
    t.boolean "gym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "others", default: "[]"
    t.boolean "walled_gated", default: false
    t.boolean "parking_space", default: false
    t.boolean "living_room", default: false
    t.boolean "dining_room", default: false
    t.boolean "waste_disposal", default: false
    t.index ["property_id"], name: "index_amenities_on_property_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "summary"
    t.text "content"
    t.string "image"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "parent_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.jsonb "conversion_rates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "user_id", null: false
    t.string "phone"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_enquiries_on_property_id"
    t.index ["user_id"], name: "index_enquiries_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "location"
    t.string "property_status"
    t.text "property_overview"
    t.integer "number_of_bedrooms"
    t.integer "number_of_bathrooms"
    t.decimal "ratings", default: "0.0"
    t.string "furnishing"
    t.decimal "size"
    t.decimal "price"
    t.date "date_listed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_property_live", default: false
    t.integer "number_of_ratings", default: 0
    t.float "latitude", default: 0.0
    t.float "longitude", default: 0.0
    t.string "currency", default: "GHS", null: false
    t.integer "hits_count", default: 0
    t.string "property_type"
    t.string "commercial_property_type"
    t.index ["currency"], name: "index_properties_on_currency"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_details", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.boolean "has_room_serviced", default: false
    t.integer "number_of_storeys"
    t.boolean "pet_friendly_compound", default: false
    t.string "compound_finishing"
    t.string "finishing"
    t.string "bathroom_type_and_location"
    t.string "year_built"
    t.string "street"
    t.string "payment_plan"
    t.string "state_of_land"
    t.string "number_of_tenants"
    t.string "type_of_meter"
    t.string "source_of_water"
    t.boolean "property_needs_renovation", default: false
    t.boolean "smoking_allowed", default: false
    t.boolean "tiled_areas", default: false
    t.string "ceiling_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_details_on_property_id"
  end

  create_table "public_facilities", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.boolean "schools", default: false
    t.boolean "hospitals", default: false
    t.boolean "pharmacies", default: false
    t.string "others", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_public_facilities_on_property_id"
  end

  create_table "recreational_facilities", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.boolean "restaurants", default: false
    t.boolean "pubs", default: false
    t.boolean "gyms", default: false
    t.string "others", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_recreational_facilities_on_property_id"
  end

  create_table "socials", force: :cascade do |t|
    t.string "instagram"
    t.string "facebook"
    t.string "twitter"
    t.string "linkedin"
    t.string "whatsapp"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_socials_on_user_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.text "address"
    t.string "country"
    t.string "company_name"
    t.string "mobile_phone"
    t.string "office_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "user_type"
    t.string "subscription"
    t.datetime "last_subscription_date"
    t.string "reference"
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "regular", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firstname"], name: "index_users_on_firstname", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["lastname"], name: "index_users_on_lastname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "amenities", "properties"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users"
  add_foreign_key "enquiries", "properties"
  add_foreign_key "enquiries", "users"
  add_foreign_key "properties", "users"
  add_foreign_key "property_details", "properties"
  add_foreign_key "public_facilities", "properties"
  add_foreign_key "recreational_facilities", "properties"
  add_foreign_key "socials", "users"
  add_foreign_key "user_details", "users"
end
