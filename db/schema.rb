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

ActiveRecord::Schema.define(version: 2019_10_15_091204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "iban"
    t.string "bic"
    t.string "bank_name"
    t.string "address"
    t.uuid "worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "subject_to_vat"
    t.index ["worker_id"], name: "index_companies_on_worker_id"
  end

  create_table "format_deliveries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "localisation"
    t.text "optional_services", default: [], array: true
    t.integer "min_price"
    t.integer "max_price"
    t.integer "min_time"
    t.integer "max_time"
    t.uuid "customer_id"
    t.uuid "worker_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "category_id"
    t.uuid "subcategory_id"
    t.date "date_delivery"
    t.string "slug", null: false
    t.uuid "format_delivery_id"
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["customer_id"], name: "index_jobs_on_customer_id"
    t.index ["format_delivery_id"], name: "index_jobs_on_format_delivery_id"
    t.index ["slug"], name: "index_jobs_on_slug", unique: true
    t.index ["subcategory_id"], name: "index_jobs_on_subcategory_id"
    t.index ["worker_id"], name: "index_jobs_on_worker_id"
  end

  create_table "professions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quote_elements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.string "quantity"
    t.string "price"
    t.string "total"
    t.uuid "quote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id"], name: "index_quote_elements_on_quote_id"
  end

  create_table "quotes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "quote_element_id"
    t.uuid "job_id"
    t.integer "status", default: 0
    t.uuid "user_id"
    t.bigint "quote_number"
    t.index ["job_id"], name: "index_quotes_on_job_id"
    t.index ["quote_element_id"], name: "index_quotes_on_quote_element_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "read_marks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "readable_type", null: false
    t.uuid "readable_id"
    t.string "reader_type", null: false
    t.uuid "reader_id"
    t.datetime "timestamp"
    t.index ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id"
    t.index ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true
    t.index ["reader_type", "reader_id"], name: "index_read_marks_on_reader_type_and_reader_id"
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.integer "stars"
    t.uuid "customer_id"
    t.uuid "worker_id"
    t.uuid "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
    t.index ["job_id"], name: "index_reviews_on_job_id"
    t.index ["worker_id"], name: "index_reviews_on_worker_id"
  end

  create_table "room_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "room_id"
    t.uuid "author_id"
    t.uuid "receiver_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_room_messages_on_author_id"
    t.index ["receiver_id"], name: "index_room_messages_on_receiver_id"
    t.index ["room_id"], name: "index_room_messages_on_room_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "author_id"
    t.uuid "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "job_id"
    t.index ["author_id", "receiver_id"], name: "index_rooms_on_author_id_and_receiver_id", unique: true
    t.index ["author_id"], name: "index_rooms_on_author_id"
    t.index ["job_id"], name: "index_rooms_on_job_id"
    t.index ["name"], name: "index_rooms_on_name", unique: true
    t.index ["receiver_id"], name: "index_rooms_on_receiver_id"
  end

  create_table "subcategories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "facebook_id"
    t.string "google_id"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "skill"
    t.integer "price_rate"
    t.string "nationality"
    t.text "description"
    t.uuid "profession_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profession_id"], name: "index_users_on_profession_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companies", "users", column: "worker_id"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "format_deliveries"
  add_foreign_key "jobs", "subcategories"
  add_foreign_key "jobs", "users", column: "customer_id"
  add_foreign_key "jobs", "users", column: "worker_id"
  add_foreign_key "quote_elements", "quotes"
  add_foreign_key "quotes", "jobs"
  add_foreign_key "quotes", "quote_elements"
  add_foreign_key "quotes", "users"
  add_foreign_key "reviews", "jobs"
  add_foreign_key "reviews", "users", column: "customer_id"
  add_foreign_key "reviews", "users", column: "worker_id"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "rooms", "jobs"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "users", "professions"
end
