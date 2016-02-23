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

ActiveRecord::Schema.define(version: 20160223042500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "admins", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
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
    t.string   "provider"
    t.string   "uid"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "bands", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "cache_stores", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.json     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cache_stores", ["created_at"], name: "index_cache_stores_on_created_at", using: :btree

  create_table "days", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.date     "date"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "set_times", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "band_id"
    t.time     "start_time"
    t.uuid     "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "day_id"
  end

  add_index "set_times", ["band_id"], name: "index_set_times_on_band_id", using: :btree
  add_index "set_times", ["day_id"], name: "index_set_times_on_day_id", using: :btree
  add_index "set_times", ["venue_id"], name: "index_set_times_on_venue_id", using: :btree

  create_table "venues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.text     "street_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
