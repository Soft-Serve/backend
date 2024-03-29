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

ActiveRecord::Schema.define(version: 2022_05_29_214950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banners", force: :cascade do |t|
    t.string "header", null: false
    t.string "photo"
    t.string "sub_header"
    t.boolean "active", default: true, null: false
    t.bigint "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_banners_on_restaurant_id"
  end

  create_table "dietaries", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "restaurant_id", null: false
    t.string "filter_name", null: false
    t.index ["restaurant_id"], name: "index_dietaries_on_restaurant_id"
  end

  create_table "dietary_instances", force: :cascade do |t|
    t.bigint "dietary_id", null: false
    t.bigint "menu_item_id", null: false
    t.index ["dietary_id"], name: "index_dietary_instances_on_dietary_id"
    t.index ["menu_item_id"], name: "index_dietary_instances_on_menu_item_id"
  end

  create_table "item_sizes", force: :cascade do |t|
    t.float "price", null: false
    t.string "unit", default: "1"
    t.bigint "menu_item_id", null: false
    t.index ["menu_item_id"], name: "index_item_sizes_on_menu_item_id"
  end

  create_table "menu_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "category_type", null: false
    t.bigint "menu_id", null: false
    t.index ["menu_id"], name: "index_menu_categories_on_menu_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "photo"
    t.text "description"
    t.bigint "menu_category_id", null: false
    t.boolean "available", default: true, null: false
    t.index ["menu_category_id"], name: "index_menu_items_on_menu_category_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "restaurant_id", null: false
    t.boolean "active", default: true, null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "onboarding_checklists", force: :cascade do |t|
    t.integer "step"
    t.string "status"
    t.bigint "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_onboarding_checklists_on_restaurant_id"
  end

  create_table "promotion_categories", force: :cascade do |t|
    t.integer "discount", null: false
    t.string "unit", default: "percentage", null: false
    t.bigint "promotion_id", null: false
    t.bigint "menu_category_id", null: false
    t.index ["menu_category_id"], name: "index_promotion_categories_on_menu_category_id"
    t.index ["promotion_id"], name: "index_promotion_categories_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "days", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.bigint "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_promotions_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo"
    t.string "colour"
    t.integer "tint"
    t.string "currency", null: false
    t.string "slug", null: false
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "province"
    t.string "postal_code"
    t.string "country"
    t.boolean "onboarding_done", default: false
    t.string "font", null: false
    t.string "background_colour", null: false
    t.integer "background_tint", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.bigint "restaurant_id"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_users_on_restaurant_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "banners", "restaurants", on_delete: :cascade
  add_foreign_key "dietaries", "restaurants", on_delete: :cascade
  add_foreign_key "dietary_instances", "dietaries", on_delete: :cascade
  add_foreign_key "dietary_instances", "menu_items", on_delete: :cascade
  add_foreign_key "item_sizes", "menu_items", on_delete: :cascade
  add_foreign_key "menu_categories", "menus", on_delete: :cascade
  add_foreign_key "menu_items", "menu_categories", on_delete: :cascade
  add_foreign_key "menus", "restaurants", on_delete: :cascade
  add_foreign_key "onboarding_checklists", "restaurants", on_delete: :cascade
  add_foreign_key "promotion_categories", "menu_categories", on_delete: :cascade
  add_foreign_key "promotion_categories", "promotions", on_delete: :cascade
  add_foreign_key "promotions", "restaurants", on_delete: :cascade
  add_foreign_key "users", "restaurants", on_delete: :cascade
end
