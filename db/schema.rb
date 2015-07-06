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

ActiveRecord::Schema.define(version: 20150705172915) do

  create_table "checkouts", force: :cascade do |t|
    t.integer  "num_checked"
    t.string   "notes"
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "outstanding"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "rating"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.string   "composer"
    t.string   "arranger"
    t.string   "libretto"
    t.string   "voice"
    t.string   "accomp"
    t.string   "genre"
    t.string   "language"
    t.string   "region"
    t.string   "theme"
    t.string   "curric"
    t.string   "additional"
    t.integer  "num_tot"
    t.integer  "num_avail"
    t.string   "res_type"
    t.string   "link"
    t.string   "pic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "region"
    t.string   "role"
  end

end
