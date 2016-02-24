# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160224003458) do

  create_table "continues", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "continues", ["user_id", "group_id"], name: "index_continues_on_user_id_and_group_id", unique: true, using: :btree

  create_table "drops", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "group_name",     limit: 255
    t.string   "group_desc",     limit: 255
    t.string   "drop_users",     limit: 255
    t.string   "continue_users", limit: 255
    t.date     "start_year"
    t.date     "start_month"
    t.date     "start_day"
    t.date     "end_year"
    t.date     "end_month"
    t.date     "end_day"
    t.integer  "check_span",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.integer  "group_num",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manages", ["user_id", "group_id"], name: "index_manages_on_user_id_and_group_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_name",              limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
