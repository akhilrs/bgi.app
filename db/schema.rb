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

ActiveRecord::Schema.define(version: 20131219120016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: true do |t|
    t.string "iso",  limit: 2
    t.string "name", limit: 80
  end

  create_table "states", force: true do |t|
    t.string  "name",       limit: 80
    t.integer "country_id"
    t.string  "iso",        limit: 10
  end

  create_table "users", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.float    "mobile"
    t.text     "address1"
    t.text     "address2"
    t.string   "state"
    t.string   "country"
    t.integer  "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end