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

ActiveRecord::Schema.define(version: 20160121185619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "bands", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "set_times", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "band_id"
    t.date     "date"
    t.time     "start_time"
    t.uuid     "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "set_times", ["band_id"], name: "index_set_times_on_band_id", using: :btree
  add_index "set_times", ["venue_id"], name: "index_set_times_on_venue_id", using: :btree

  create_table "venues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.text     "street_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
