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

ActiveRecord::Schema.define(version: 20170317120631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "address"
    t.float    "longtitude"
    t.float    "latitude"
    t.boolean  "head_office"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_addresses_on_company_id", using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_articles_on_company_id", using: :btree
    t.index ["title"], name: "index_articles_on_title", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "benefits", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_benefits_on_company_id", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.integer  "interested_in"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["job_id"], name: "index_candidates_on_job_id", using: :btree
    t.index ["user_id"], name: "index_candidates_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.text     "introduction"
    t.string   "founder"
    t.string   "country"
    t.integer  "company_size"
    t.date     "founder_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["name"], name: "index_companies_on_name", using: :btree
    t.index ["website"], name: "index_companies_on_website", using: :btree
  end

  create_table "education_about_translations", force: :cascade do |t|
    t.integer  "education_about_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
    t.text     "content"
    t.index ["education_about_id"], name: "index_education_about_translations_on_education_about_id", using: :btree
    t.index ["locale"], name: "index_education_about_translations_on_locale", using: :btree
  end

  create_table "education_abouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_comments_on_user_id", using: :btree
  end

  create_table "education_course_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_course_members_on_user_id", using: :btree
  end
end
