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

ActiveRecord::Schema[7.0].define(version: 2023_09_05_150930) do
  create_table "addresses", force: :cascade do |t|
    t.string "lookup_id"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.string "country"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applicants", force: :cascade do |t|
    t.integer "client_detail_id"
    t.string "first_name"
    t.string "last_name"
    t.string "other_names"
    t.date "date_of_birth"
    t.string "nino"
    t.string "telephone_number"
    t.string "correspondence_address_type"
    t.integer "home_address_id"
    t.integer "correspondence_address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["correspondence_address_id"], name: "index_applicants_on_correspondence_address_id"
    t.index ["home_address_id"], name: "index_applicants_on_home_address_id"
  end

  create_table "case_details", force: :cascade do |t|
    t.integer "maat_application_id"
    t.string "urn"
    t.string "case_type"
    t.string "appeal_maat_id"
    t.datetime "appeal_lodged_date"
    t.string "appeal_with_changes_details"
    t.string "offence_class"
    t.string "hearing_court_name"
    t.datetime "hearing_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_details", force: :cascade do |t|
    t.integer "maat_application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests_of_justices", force: :cascade do |t|
    t.integer "maat_application_id"
    t.string "ioj_type"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maat_applications", force: :cascade do |t|
    t.string "maat_id"
    t.float "schema_version"
    t.integer "reference"
    t.string "application_type"
    t.datetime "submitted_at"
    t.datetime "declaration_signed_at"
    t.datetime "date_stamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provider_details", force: :cascade do |t|
    t.integer "maat_application_id"
    t.string "office_code"
    t.string "provider_email"
    t.string "legal_rep_first_name"
    t.string "legal_rep_last_name"
    t.string "legal_rep_telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "applicants", "addresses", column: "correspondence_address_id"
  add_foreign_key "applicants", "addresses", column: "home_address_id"
  add_foreign_key "applicants", "client_details"
  add_foreign_key "case_details", "maat_applications"
  add_foreign_key "client_details", "maat_applications"
  add_foreign_key "interests_of_justices", "maat_applications"
  add_foreign_key "provider_details", "maat_applications"
end
