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

ActiveRecord::Schema[7.0].define(version: 2023_10_03_143424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "others"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_amenities_on_property_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "content"
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
    t.bigint "category_id", null: false
    t.string "name"
    t.string "location"
    t.string "property_status"
    t.text "images"
    t.text "video"
    t.text "property_overview"
    t.integer "number_of_bedrooms"
    t.integer "number_of_bathrooms"
    t.decimal "ratings"
    t.string "furnishing"
    t.decimal "size"
    t.decimal "price"
    t.date "date_listed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_properties_on_category_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.string "role"
    t.text "address"
    t.string "country"
    t.string "profile_picture"
    t.string "company_name"
    t.string "mobile_phone"
    t.string "office_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "user_type"
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "amenities", "properties"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users"
  add_foreign_key "enquiries", "properties"
  add_foreign_key "enquiries", "users"
  add_foreign_key "properties", "categories"
  add_foreign_key "properties", "users"
  add_foreign_key "user_details", "users"
end
