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

ActiveRecord::Schema[7.2].define(version: 2025_09_29_124932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appreciations", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.text "message", null: false
    t.integer "category", null: false
    t.boolean "is_public", default: true
    t.integer "likes_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_appreciations_on_category"
    t.index ["organization_id", "created_at"], name: "index_appreciations_on_organization_id_and_created_at"
    t.index ["organization_id", "receiver_id"], name: "index_appreciations_on_organization_id_and_receiver_id"
    t.index ["organization_id", "sender_id"], name: "index_appreciations_on_organization_id_and_sender_id"
    t.index ["organization_id"], name: "index_appreciations_on_organization_id"
    t.index ["receiver_id"], name: "index_appreciations_on_receiver_id"
    t.index ["sender_id"], name: "index_appreciations_on_sender_id"
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "office_id"
    t.string "name", limit: 100, null: false
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_departments_on_manager_id"
    t.index ["office_id"], name: "index_departments_on_office_id"
    t.index ["organization_id", "name"], name: "index_departments_on_organization_id_and_name"
    t.index ["organization_id"], name: "index_departments_on_organization_id"
  end

  create_table "offices", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", limit: 100, null: false
    t.string "address"
    t.boolean "is_headquarters", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_offices_on_organization_id_and_name"
    t.index ["organization_id"], name: "index_offices_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "department_id"
    t.string "name", limit: 100, null: false
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_sections_on_department_id"
    t.index ["manager_id"], name: "index_sections_on_manager_id"
    t.index ["organization_id", "name"], name: "index_sections_on_organization_id_and_name"
    t.index ["organization_id"], name: "index_sections_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "organization_id", null: false
    t.bigint "office_id"
    t.bigint "department_id"
    t.bigint "section_id"
    t.string "employee_id"
    t.string "position"
    t.integer "role", default: 0
    t.integer "status", default: 1
    t.date "hire_date"
    t.text "bio"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["office_id"], name: "index_users_on_office_id"
    t.index ["organization_id", "employee_id"], name: "index_users_on_organization_id_and_employee_id", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["section_id"], name: "index_users_on_section_id"
    t.index ["status"], name: "index_users_on_status"
  end

  add_foreign_key "appreciations", "organizations"
  add_foreign_key "appreciations", "users", column: "receiver_id"
  add_foreign_key "appreciations", "users", column: "sender_id"
  add_foreign_key "departments", "offices"
  add_foreign_key "departments", "organizations"
  add_foreign_key "departments", "users", column: "manager_id"
  add_foreign_key "offices", "organizations"
  add_foreign_key "sections", "departments"
  add_foreign_key "sections", "organizations"
  add_foreign_key "sections", "users", column: "manager_id"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "offices"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "sections"
end
