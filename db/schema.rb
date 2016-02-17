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

ActiveRecord::Schema.define(version: 20160216125647) do

  create_table "distances", force: :cascade do |t|
    t.integer  "point_id"
    t.integer  "neighbor_id"
    t.integer  "distance"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "points", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "route_uploads", force: :cascade do |t|
    t.integer  "route_id"
    t.string   "route_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.integer  "speed"
    t.integer  "places_count"
    t.datetime "daparture"
    t.decimal  "tariff",       precision: 8, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "shedules", force: :cascade do |t|
    t.integer  "point_id"
    t.integer  "route_id"
    t.time     "breack"
    t.boolean  "first_point", default: false
    t.boolean  "last_point",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
