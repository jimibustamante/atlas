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

ActiveRecord::Schema.define(version: 20151214195327) do

  create_table "communes", force: :cascade do |t|
    t.integer  "province_id", limit: 4,   null: false
    t.string   "name",        limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "labors", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "owner_id",   limit: 4,   null: false
    t.integer  "commune_id", limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "labors", ["commune_id"], name: "index_labors_on_commune_id", using: :btree
  add_index "labors", ["owner_id"], name: "index_labors_on_owner_id", using: :btree

  create_table "mining_wastes", force: :cascade do |t|
    t.integer  "sernageomin_id",            limit: 4,                            null: false
    t.string   "status",                    limit: 255,                          null: false
    t.string   "name",                      limit: 255
    t.decimal  "height",                                precision: 10, scale: 6
    t.string   "utm_north",                 limit: 255
    t.string   "utm_east",                  limit: 255
    t.decimal  "lon",                                   precision: 10, scale: 6
    t.decimal  "lat",                                   precision: 10, scale: 6
    t.integer  "labor_id",                  limit: 4,                            null: false
    t.integer  "region_id",                 limit: 4,                            null: false
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "mining_waste_type",         limit: 255
    t.string   "partial_volume",            limit: 255
    t.string   "total_volume",              limit: 255
    t.string   "partial_ton",               limit: 255
    t.string   "total_ton",                 limit: 255
    t.string   "resolution",                limit: 255
    t.date     "resolution_date"
    t.string   "resolution_number",         limit: 255
    t.date     "resolution_closure_date"
    t.string   "resolution_closure_number", limit: 255
  end

  add_index "mining_wastes", ["labor_id"], name: "index_mining_wastes_on_labor_id", using: :btree
  add_index "mining_wastes", ["region_id"], name: "index_mining_wastes_on_region_id", using: :btree
  add_index "mining_wastes", ["sernageomin_id"], name: "index_mining_wastes_on_sernageomin_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "region_id",  limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",          limit: 255, null: false
    t.string   "region_number", limit: 255, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
