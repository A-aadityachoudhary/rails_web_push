# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2026_07_31_055723) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "notification_campaigns", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "icon"
    t.text "image"
    t.string "action_title"
    t.text "action_url"
    t.integer "total_sent"
    t.integer "success_count"
    t.integer "failed_count"
    t.integer "in_flight_count"
    t.integer "clicked_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_statuses", force: :cascade do |t|
    t.bigint "push_subscription_id", null: false
    t.string "title"
    t.text "body"
    t.integer "status"
    t.text "failure_reason"
    t.datetime "clicked_at"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "notification_campaign_id"
    t.index ["notification_campaign_id"], name: "index_notification_statuses_on_notification_campaign_id"
    t.index ["push_subscription_id"], name: "index_notification_statuses_on_push_subscription_id"
  end

  create_table "push_subscriptions", force: :cascade do |t|
    t.text "endpoint"
    t.text "p256dh"
    t.text "auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "browser"
  end

  add_foreign_key "notification_statuses", "notification_campaigns"
  add_foreign_key "notification_statuses", "push_subscriptions"
end
