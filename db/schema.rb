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

ActiveRecord::Schema.define(version: 20180128105511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "privacy"
    t.boolean  "complete",           default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id"
    t.datetime "assigned_at"
    t.datetime "completed_at"
    t.integer  "time_taken"
    t.integer  "dev_status",         default: 0
    t.integer  "qa_status",          default: 0
    t.integer  "priority",           default: 0
    t.integer  "category",           default: 0
    t.integer  "environment",        default: 0
    t.text     "comments"
    t.integer  "times_repeated"
    t.boolean  "is_deleted",         default: false
    t.boolean  "unit_tested",        default: false
    t.datetime "unit_tests_started"
    t.integer  "assigned_to",        default: 0
    t.integer  "product_type",       default: 0
    t.integer  "caused_by",          default: 0
    t.datetime "started_at"
    t.integer  "level",              default: 0
    t.integer  "reported_by",        default: 0
    t.datetime "reported_at"
    t.integer  "sprint",             default: 0
    t.index ["assigned_to"], name: "index_tasks_on_assigned_to", using: :btree
    t.index ["category"], name: "index_tasks_on_category", using: :btree
    t.index ["dev_status"], name: "index_tasks_on_dev_status", using: :btree
    t.index ["environment"], name: "index_tasks_on_environment", using: :btree
    t.index ["priority"], name: "index_tasks_on_priority", using: :btree
    t.index ["product_type"], name: "index_tasks_on_product_type", using: :btree
    t.index ["qa_status"], name: "index_tasks_on_qa_status", using: :btree
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "tasks", "users"
end
