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

ActiveRecord::Schema.define(version: 20160525184238) do

  create_table "short_urls", force: :cascade do |t|
    t.string   "long_url",     limit: 255
    t.string   "shorty",       limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "visits_count", limit: 4,   default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "track",                    default: false
  end

  add_index "short_urls", ["user_id"], name: "index_short_urls_on_user_id", using: :btree

  create_table "short_visits", force: :cascade do |t|
    t.integer  "short_url_id",         limit: 4
    t.string   "visitor_ip",           limit: 255
    t.string   "visitor_city",         limit: 255
    t.string   "visitor_state",        limit: 255
    t.string   "visitor_country_iso2", limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "short_visits", ["short_url_id"], name: "fk_rails_b8aeb0871d", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "email",              limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "salt",               limit: 255
    t.string   "api_token",          limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "short_urls", "users"
  add_foreign_key "short_visits", "short_urls"
end
