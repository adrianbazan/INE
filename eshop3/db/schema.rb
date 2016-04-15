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

ActiveRecord::Schema.define(version: 20160412123806) do

  create_table "directors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directors_films", force: true do |t|
    t.integer  "director_id", null: false
    t.integer  "film_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directors_films", ["director_id"], name: "fk_directors_films_directors", using: :btree
  add_index "directors_films", ["film_id"], name: "fk_directors_films_films", using: :btree

  create_table "films", force: true do |t|
    t.string   "title",                               null: false
    t.integer  "producer_id",                         null: false
    t.datetime "produced_at"
    t.string   "cod",                      limit: 13
    t.text     "blurb"
    t.integer  "duration"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
  end

  add_index "films", ["producer_id"], name: "fk_films_producers", using: :btree

  create_table "producers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
