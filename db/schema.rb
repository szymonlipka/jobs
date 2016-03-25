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

ActiveRecord::Schema.define(version: 20160324090123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.string   "id_char" # Idenctification character specyfic to each job
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "more_important_jobs" # String containing id_chars of all more important jobs
  end

  add_index "jobs", ["id_char"], name: "index_jobs_on_id_char", using: :btree
  add_index "jobs", ["more_important_jobs"], name: "index_jobs_on_more_important_jobs", using: :btree
  add_index "jobs", ["name"], name: "index_jobs_on_name", using: :btree

end
