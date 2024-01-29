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

ActiveRecord::Schema[7.0].define(version: 2024_01_29_023654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.date "date"
    t.string "to_do"
    t.bigint "client_id", null: false
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_activities_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "phone", default: "", null: false
    t.decimal "amount_owed", default: "0.0", null: false
    t.string "address", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "claim_no", default: "", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.integer "status"
    t.decimal "amount_owed"
    t.string "property_sold"
    t.string "country"
    t.date "date_sold"
    t.string "mortgage_company"
    t.decimal "initial_bit_amount"
    t.decimal "sold_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "index_leads_on_client_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "client_id", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_notes_on_author_id"
    t.index ["client_id"], name: "index_notes_on_client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "userable_type", null: false
    t.bigint "userable_id", null: false
    t.index ["userable_type", "userable_id"], name: "index_users_on_userable"
  end

  add_foreign_key "activities", "clients"
  add_foreign_key "leads", "clients"
  add_foreign_key "notes", "clients"
  add_foreign_key "notes", "users", column: "author_id"
end
