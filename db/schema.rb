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

ActiveRecord::Schema[7.2].define(version: 2024_12_09_042639) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date "appointment_date", null: false
    t.time "scheduled_time", null: false
    t.integer "status", default: 0, null: false
    t.bigint "clinic_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_id"], name: "index_appointments_on_clinic_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "available_times", force: :cascade do |t|
    t.text "weekday", null: false
    t.time "available_time_slot", null: false
    t.bigint "clinic_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_id"], name: "index_available_times_on_clinic_id"
    t.index ["user_id"], name: "index_available_times_on_user_id"
  end

  create_table "clinics", force: :cascade do |t|
    t.string "clinic_name", null: false
    t.string "doctor_name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clinics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "visit_intervals", force: :cascade do |t|
    t.integer "interval", null: false
    t.bigint "clinic_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_id"], name: "index_visit_intervals_on_clinic_id"
    t.index ["user_id"], name: "index_visit_intervals_on_user_id"
  end

  add_foreign_key "appointments", "clinics"
  add_foreign_key "appointments", "users"
  add_foreign_key "available_times", "clinics"
  add_foreign_key "available_times", "users"
  add_foreign_key "clinics", "users"
  add_foreign_key "visit_intervals", "clinics"
  add_foreign_key "visit_intervals", "users"
end
