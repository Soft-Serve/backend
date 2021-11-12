# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_16_211616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_foreign_key "dietaries", "restaurants", on_delete: :cascade
  add_foreign_key "dietary_instances", "dietaries", on_delete: :cascade
  add_foreign_key "dietary_instances", "menu_items", on_delete: :cascade
  add_foreign_key "item_sizes", "menu_items", on_delete: :cascade
  add_foreign_key "menu_categories", "menus", on_delete: :cascade
  add_foreign_key "menu_items", "menu_categories", on_delete: :cascade
  add_foreign_key "menus", "restaurants", on_delete: :cascade
  add_foreign_key "users", "restaurants", on_delete: :cascade
end
