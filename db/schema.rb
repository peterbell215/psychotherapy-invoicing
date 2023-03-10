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

ActiveRecord::Schema[7.0].define(version: 2023_01_01_062745) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "address1", null: false
    t.string "address2"
    t.string "town", null: false
    t.string "postcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["email"], name: "index_clients_on_email"
    t.index ["name"], name: "index_clients_on_name"
  end

  create_table "session_charges", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.date "from", null: false
    t.date "to"
    t.integer "hourly_charge_rate_pence", default: 6000, null: false
    t.string "hourly_charge_rate_currency", default: "GBP", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_session_charges_on_client_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "start", null: false
    t.integer "duration", null: false
    t.integer "hourly_charge_pence", default: 0, null: false
    t.string "hourly_charge_currency", default: "GBP", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_sessions_on_client_id"
  end

  add_foreign_key "session_charges", "clients"
  add_foreign_key "sessions", "clients"
end
