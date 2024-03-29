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

ActiveRecord::Schema.define(version: 20160722234552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "activity_type",  null: false
    t.integer  "monster_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "monster_number"
  end

  add_index "activities", ["monster_id"], name: "index_activities_on_monster_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "chatrooms", force: :cascade do |t|
    t.datetime "last_joined_at"
    t.decimal  "lat",            precision: 10, scale: 6
    t.decimal  "lng",            precision: 10, scale: 6
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "monsters", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat",              precision: 10, scale: 6
    t.decimal  "lng",              precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
    t.boolean  "active",                                    default: true
    t.integer  "upvote_count",                              default: 0
    t.integer  "downvote_count",                            default: 0
    t.integer  "total_vote_count",                          default: 0
    t.boolean  "seen",                                      default: false
    t.datetime "expires_at"
    t.json     "payload"
  end

  create_table "users", force: :cascade do |t|
    t.text     "uuid"
    t.text     "name"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.text     "channel_id"
    t.decimal  "lat",                 precision: 10, scale: 6
    t.decimal  "lng",                 precision: 10, scale: 6
    t.datetime "monsters_checked_at"
  end

  add_foreign_key "activities", "monsters"
  add_foreign_key "activities", "users"
end
