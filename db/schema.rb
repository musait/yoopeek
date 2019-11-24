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

ActiveRecord::Schema.define(version: 2019_11_24_113333) do

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

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "country"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "complete_address"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", default: " "
    t.string "iban"
    t.string "bic"
    t.string "bank_name"
    t.string "address"
    t.uuid "worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "subject_to_vat"
    t.uuid "address_id"
    t.string "vat_number"
    t.string "website"
    t.string "currency"
    t.index ["address_id"], name: "index_companies_on_address_id"
    t.index ["worker_id"], name: "index_companies_on_worker_id"
  end

  create_table "credit_changements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.boolean "is_for_add", default: false
    t.float "quantity", default: 0.0
    t.uuid "credits_payment_id"
    t.uuid "subscription_id"
    t.uuid "room_id"
    t.integer "create_for", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credits_payment_id"], name: "index_credit_changements_on_credits_payment_id"
    t.index ["room_id"], name: "index_credit_changements_on_room_id"
    t.index ["subscription_id"], name: "index_credit_changements_on_subscription_id"
    t.index ["user_id"], name: "index_credit_changements_on_user_id"
  end

  create_table "credits_offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "credits"
    t.float "price"
    t.float "reduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credits_payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.float "credits_add"
    t.float "amount"
    t.string "stripe_intent_id"
    t.string "stripe_payment_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_number"
    t.uuid "credits_offer_id"
    t.index ["credits_offer_id"], name: "index_credits_payments_on_credits_offer_id"
    t.index ["user_id"], name: "index_credits_payments_on_user_id"
  end

  create_table "forbiden_words", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "word"
    t.boolean "is_valid_after_quote_accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_catched_word", default: false
  end

  create_table "format_deliveries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_elements", force: :cascade do |t|
    t.string "content"
    t.integer "quantity"
    t.float "price"
    t.float "total"
    t.uuid "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_elements_on_invoice_id"
  end

  create_table "invoices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "sender_id"
    t.uuid "receiver_id"
    t.uuid "job_id"
    t.uuid "quote_id"
    t.integer "invoice_number"
    t.integer "vat"
    t.integer "total_within_vat"
    t.integer "total_without_vat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "commission_collected"
    t.integer "commission_invoice_number"
    t.string "stripe_intent_id"
    t.index ["job_id"], name: "index_invoices_on_job_id"
    t.index ["quote_id"], name: "index_invoices_on_quote_id"
    t.index ["receiver_id"], name: "index_invoices_on_receiver_id"
    t.index ["sender_id"], name: "index_invoices_on_sender_id"
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
    t.integer "sold_at", default: 0
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["customer_id"], name: "index_jobs_on_customer_id"
    t.index ["format_delivery_id"], name: "index_jobs_on_format_delivery_id"
    t.index ["slug"], name: "index_jobs_on_slug", unique: true
    t.index ["subcategory_id"], name: "index_jobs_on_subcategory_id"
    t.index ["worker_id"], name: "index_jobs_on_worker_id"
  end

  create_table "join_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "category_id"
    t.uuid "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_join_categories_on_category_id"
    t.index ["subcategory_id"], name: "index_join_categories_on_subcategory_id"
  end

  create_table "join_profession_subcategories", force: :cascade do |t|
    t.uuid "profession_id"
    t.uuid "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profession_id"], name: "index_join_profession_subcategories_on_profession_id"
    t.index ["subcategory_id"], name: "index_join_profession_subcategories_on_subcategory_id"
  end

  create_table "join_tag_workers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tag_id"
    t.uuid "worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_join_tag_workers_on_tag_id"
    t.index ["worker_id"], name: "index_join_tag_workers_on_worker_id"
  end

  create_table "join_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "category_id"
    t.uuid "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_join_tags_on_category_id"
    t.index ["tag_id"], name: "index_join_tags_on_tag_id"
  end

  create_table "join_user_subcategories", force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subcategory_id"], name: "index_join_user_subcategories_on_subcategory_id"
    t.index ["user_id"], name: "index_join_user_subcategories_on_user_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "message"
    t.string "created_for"
    t.datetime "viewed_at"
    t.uuid "quote_id"
    t.uuid "job_id"
    t.uuid "room_message_id"
    t.uuid "review_id"
    t.uuid "sender_id"
    t.uuid "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_notifications_on_job_id"
    t.index ["quote_id"], name: "index_notifications_on_quote_id"
    t.index ["review_id"], name: "index_notifications_on_review_id"
    t.index ["room_message_id"], name: "index_notifications_on_room_message_id"
  end

  create_table "plan_limitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.string "description"
    t.float "price_per_month", default: 0.0
    t.float "commission_per_service", default: 19.0
    t.integer "commission_type", default: 0
    t.integer "nb_answer", default: 6
    t.integer "nb_answer_type", default: 0
    t.integer "limit_portfolio", default: 0
    t.boolean "have_badge", default: false
    t.boolean "have_status", default: false
    t.integer "show_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_plan_id"
    t.integer "limit_portfolio_content"
  end

  create_table "portfolios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "professions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quote_elements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.integer "quantity", default: 1
    t.integer "price"
    t.integer "total"
    t.uuid "quote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id"], name: "index_quote_elements_on_quote_id"
  end

  create_table "quotes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "sender_id"
    t.uuid "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "quote_element_id"
    t.uuid "job_id"
    t.integer "status", default: 0
    t.uuid "user_id"
    t.bigint "quote_number", default: 0
    t.integer "total_without_vat"
    t.integer "vat"
    t.integer "total_within_vat"
    t.float "commission_collected"
    t.string "stripe_intent_id"
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
    t.boolean "is_valid", default: true
    t.string "unvalid_reason"
    t.boolean "is_catched", default: false
    t.string "catched_reason"
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
    t.index ["author_id"], name: "index_rooms_on_author_id"
    t.index ["job_id"], name: "index_rooms_on_job_id"
    t.index ["name"], name: "index_rooms_on_name", unique: true
    t.index ["receiver_id"], name: "index_rooms_on_receiver_id"
  end

  create_table "stripe_payouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "stripe_payout_id"
    t.uuid "user_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stripe_payouts_on_user_id"
  end

  create_table "stripe_subscription_cancels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "subscription_end_at"
    t.float "plan_amount"
    t.string "stripe_subscription_id"
    t.string "stripe_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "subscription_id"
    t.index ["subscription_id"], name: "index_stripe_subscription_cancels_on_subscription_id"
    t.index ["user_id"], name: "index_stripe_subscription_cancels_on_user_id"
  end

  create_table "subcategories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "plan_limitation_id"
    t.float "plan_amount"
    t.string "stripe_plan_id"
    t.string "stripe_subscription_id"
    t.datetime "subscription_canceled_at"
    t.datetime "end_at"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_number"
    t.index ["plan_limitation_id"], name: "index_subscriptions_on_plan_limitation_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "category_id"
    t.index ["category_id"], name: "index_tags_on_category_id"
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
    t.text "skills", default: [], array: true
    t.integer "price_rate"
    t.string "nationality"
    t.text "description"
    t.uuid "profession_id"
    t.uuid "address_id"
    t.boolean "is_worker"
    t.boolean "approved", default: false, null: false
    t.boolean "admin", default: false
    t.string "phone_number"
    t.integer "notifications_count"
    t.string "stripe_customer_id"
    t.string "stripe_account_id"
    t.string "last_stripe_payment_method_id"
    t.string "stripe"
    t.string "stripe_subscription_id"
    t.string "stripe_plan_id"
    t.float "current_plan_amount"
    t.datetime "subscription_end_at"
    t.uuid "portfolio_id"
    t.uuid "category_id"
    t.string "facebook_profile"
    t.string "instagram_profile"
    t.string "pinterest_profile"
    t.string "twitter_profile"
    t.float "current_credits", default: 0.0
    t.float "total_credits", default: 0.0
    t.datetime "birthdate"
    t.string "stripe_person_id"
    t.string "stripe_connect_bank_id"
    t.float "available_payout_amount", default: 0.0
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["category_id"], name: "index_users_on_category_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["portfolio_id"], name: "index_users_on_portfolio_id"
    t.index ["profession_id"], name: "index_users_on_profession_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companies", "addresses"
  add_foreign_key "companies", "users", column: "worker_id"
  add_foreign_key "credit_changements", "credits_payments"
  add_foreign_key "credit_changements", "rooms"
  add_foreign_key "credit_changements", "subscriptions"
  add_foreign_key "credit_changements", "users"
  add_foreign_key "credits_payments", "credits_offers"
  add_foreign_key "credits_payments", "users"
  add_foreign_key "invoice_elements", "invoices"
  add_foreign_key "invoices", "jobs"
  add_foreign_key "invoices", "quotes"
  add_foreign_key "invoices", "users", column: "receiver_id"
  add_foreign_key "invoices", "users", column: "sender_id"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "format_deliveries"
  add_foreign_key "jobs", "subcategories"
  add_foreign_key "jobs", "users", column: "customer_id"
  add_foreign_key "jobs", "users", column: "worker_id"
  add_foreign_key "notifications", "jobs"
  add_foreign_key "notifications", "quotes"
  add_foreign_key "notifications", "reviews"
  add_foreign_key "notifications", "room_messages"
  add_foreign_key "portfolios", "users"
  add_foreign_key "quote_elements", "quotes"
  add_foreign_key "quotes", "jobs"
  add_foreign_key "quotes", "quote_elements"
  add_foreign_key "quotes", "users"
  add_foreign_key "reviews", "jobs"
  add_foreign_key "reviews", "users", column: "customer_id"
  add_foreign_key "reviews", "users", column: "worker_id"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "rooms", "jobs"
  add_foreign_key "stripe_payouts", "users"
  add_foreign_key "stripe_subscription_cancels", "subscriptions"
  add_foreign_key "stripe_subscription_cancels", "users"
  add_foreign_key "subscriptions", "plan_limitations"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tags", "categories"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "categories"
  add_foreign_key "users", "portfolios"
  add_foreign_key "users", "professions"
end
