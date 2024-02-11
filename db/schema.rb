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

ActiveRecord::Schema[7.0].define(version: 2024_02_11_163542) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.date "date"
    t.string "to_do"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "assignee_type", null: false
    t.bigint "assignee_id", null: false
    t.integer "status", default: 0, null: false
    t.index ["assignee_type", "assignee_id"], name: "index_activities_on_assignee"
    t.check_constraint "status = ANY (ARRAY[0, 1])", name: "check_status"
  end

  create_table "clients", force: :cascade do |t|
    t.string "phone", default: "", null: false
    t.decimal "amount_owed", default: "0.0", null: false
    t.string "address", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "claim_no", default: "", null: false
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.integer "status"
    t.decimal "amount_owed"
    t.string "property_sold"
    t.string "county"
    t.date "date_sold"
    t.string "mortgage_company"
    t.decimal "initial_bid_amount"
    t.decimal "sold_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.bigint "label_id", null: false
    t.string "name", default: "", null: false
    t.index ["client_id"], name: "index_leads_on_client_id"
    t.index ["label_id"], name: "index_leads_on_label_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "noteable_type", null: false
    t.bigint "noteable_id", null: false
    t.index ["author_id"], name: "index_notes_on_author_id"
    t.index ["noteable_type", "noteable_id"], name: "index_notes_on_noteable"
  end

  create_table "quickbooks_credentials", force: :cascade do |t|
    t.text "access_token", null: false
    t.datetime "access_token_expires_at", precision: nil, null: false
    t.text "refresh_token", null: false
    t.datetime "refresh_token_expires_at", precision: nil, null: false
    t.text "realm_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_quickbooks_credentials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "phone_no", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, where: "((email IS NOT NULL) AND ((email)::text <> ''::text))"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "leads", "clients"
  add_foreign_key "leads", "labels"
  add_foreign_key "notes", "users", column: "author_id"
  add_foreign_key "quickbooks_credentials", "users", on_delete: :cascade
end
