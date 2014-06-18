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

ActiveRecord::Schema.define(version: 20140617144848) do

  create_table "child_infos", force: true do |t|
    t.integer  "age"
    t.datetime "date_of_birth"
    t.integer  "client_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_infos", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.integer  "pincode"
    t.datetime "date_of_birth"
    t.string   "mobile"
    t.string   "phone"
    t.string   "email"
    t.string   "education"
    t.string   "occupation"
    t.string   "job_post"
    t.string   "name_of_company"
    t.integer  "job_expirience_year"
    t.float    "income"
    t.float    "economical_liability"
    t.integer  "number_of_child"
    t.datetime "anniversary_date"
    t.string   "intend_to_work"
    t.string   "short_term_goal"
    t.string   "long_term_goal"
    t.integer  "retirement_age"
    t.string   "plan_child_education"
    t.string   "plan_child_marriage"
    t.string   "plan_retirement_fund"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: true do |t|
    t.integer  "owned"
    t.integer  "rented"
    t.integer  "co_provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investment_types", force: true do |t|
    t.float    "fix_income"
    t.float    "equity"
    t.float    "gold"
    t.float    "land_and_estate"
    t.integer  "client_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", force: true do |t|
    t.integer  "four_wheeler"
    t.integer  "two_wheeler"
    t.integer  "none"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
