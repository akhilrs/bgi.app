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

ActiveRecord::Schema.define(version: 20140110085236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calllogs", force: true do |t|
    t.integer  "phone_id"
    t.string   "number",     limit: 13
    t.string   "name",       limit: 50
    t.string   "calltype",   limit: 10
    t.datetime "datetime"
    t.time     "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string "iso",  limit: 2
    t.string "name", limit: 80
  end

  create_table "phones", force: true do |t|
    t.integer  "user_id"
    t.string   "number",     limit: 13
    t.string   "model",      limit: 20
    t.string   "make",       limit: 30
    t.string   "imei",       limit: 17
    t.string   "serialno",   limit: 30
    t.integer  "primary",    limit: 2,  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string  "name",       limit: 80
    t.integer "country_id"
    t.string  "iso",        limit: 10
  end

  create_table "users", force: true do |t|
    t.string   "fname",                  limit: 50
    t.string   "lname",                  limit: 50
    t.string   "image"
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.integer  "facebook",               limit: 2,  default: 0
    t.integer  "google_oauth2",          limit: 2,  default: 0
    t.string   "fid"
    t.string   "gid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
