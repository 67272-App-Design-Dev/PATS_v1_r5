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

ActiveRecord::Schema.define(version: 2018_01_02_204046) do

  create_table "animal_medicines", force: :cascade do |t|
    t.integer "animal_id"
    t.integer "medicine_id"
    t.integer "recommended_num_of_units"
    t.index ["animal_id"], name: "index_animal_medicines_on_animal_id"
    t.index ["medicine_id"], name: "index_animal_medicines_on_medicine_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
  end

  create_table "dosages", force: :cascade do |t|
    t.integer "visit_id"
    t.integer "medicine_id"
    t.integer "units_given"
    t.float "discount", default: 0.0
    t.index ["medicine_id"], name: "index_dosages_on_medicine_id"
    t.index ["visit_id"], name: "index_dosages_on_visit_id"
  end

  create_table "medicine_costs", force: :cascade do |t|
    t.integer "medicine_id"
    t.integer "cost_per_unit"
    t.date "start_date"
    t.date "end_date"
    t.index ["medicine_id"], name: "index_medicine_costs_on_medicine_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "stock_amount"
    t.string "admin_method"
    t.string "unit"
    t.boolean "vaccine"
    t.boolean "active", default: true
  end

  create_table "notes", force: :cascade do |t|
    t.string "notable_type"
    t.integer "notable_id"
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.datetime "written_on"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "email"
    t.boolean "active", default: true
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "animal_id"
    t.integer "owner_id"
    t.boolean "female"
    t.date "date_of_birth"
    t.boolean "active", default: true
    t.index ["animal_id"], name: "index_pets_on_animal_id"
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  create_table "procedure_costs", force: :cascade do |t|
    t.integer "procedure_id"
    t.integer "cost"
    t.date "start_date"
    t.date "end_date"
    t.index ["procedure_id"], name: "index_procedure_costs_on_procedure_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "length_of_time"
    t.boolean "active", default: true
  end

  create_table "treatments", force: :cascade do |t|
    t.integer "visit_id"
    t.integer "procedure_id"
    t.boolean "successful"
    t.float "discount", default: 0.0
    t.index ["procedure_id"], name: "index_treatments_on_procedure_id"
    t.index ["visit_id"], name: "index_treatments_on_visit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "username"
    t.string "password_digest"
    t.boolean "active"
  end

  create_table "visits", force: :cascade do |t|
    t.integer "pet_id"
    t.date "date"
    t.float "weight"
    t.boolean "overnight_stay"
    t.integer "total_charge"
    t.index ["pet_id"], name: "index_visits_on_pet_id"
  end

end
