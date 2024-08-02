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

ActiveRecord::Schema[7.1].define(version: 2024_07_31_123352) do
  create_table "affiliates", force: :cascade do |t|
    t.string "paytm_number"
    t.string "upi_id"
    t.string "campaign_name"
    t.string "refer_code"
    t.integer "referrers_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "click_id"
  end

  create_table "app_banners", force: :cascade do |t|
    t.string "title"
    t.string "image_url"
    t.string "action_url"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_offers", force: :cascade do |t|
    t.string "offer_name"
    t.string "offer_amount", default: "0"
    t.boolean "status", default: true
    t.text "description"
    t.string "daily_cap", default: "0"
    t.string "whatsapp_link"
    t.boolean "insta_offer", default: false
    t.boolean "retention_offer", default: false
    t.boolean "event_offer", default: false
    t.string "identifier"
    t.string "refer_amount", default: "0"
    t.string "image_url", default: "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.pngall.com%2Fwp-content%2Fuploads%2F2016%2F07%2FSpecial-offer-PNG-Images.png&f=1&nofb=1&ipt=6ecc7274e6f401a747c1eb85e483ce0b38037a10443a9f09c2db1d4463c588a7&ipo=images"
    t.text "instructions"
    t.string "action_url"
    t.integer "offer_priority", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.string "category"
    t.string "image_url"
    t.boolean "status", default: true
    t.boolean "highlighted", default: true
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_events", force: :cascade do |t|
    t.string "event_title"
    t.string "event_amount"
    t.string "pay_type"
    t.integer "event_order", default: 1
    t.integer "app_offer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_offer_id"], name: "index_offer_events_on_app_offer_id"
  end

  create_table "postbacks", force: :cascade do |t|
    t.string "click_id"
    t.string "offer"
    t.string "event"
    t.string "source_ip"
    t.boolean "status", default: true
    t.string "aff_status"
    t.string "ref_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrers", force: :cascade do |t|
    t.string "live_offer_id"
    t.integer "app_offer_id", null: false
    t.string "click_id"
    t.integer "affiliate_id", null: false
    t.string "paytm_number"
    t.string "upi_id"
    t.string "source_ip"
    t.boolean "aff_status", default: false
    t.boolean "ref_status", default: false
    t.string "aff_order_id"
    t.string "ref_order_id"
    t.string "aff_pay_response"
    t.string "ref_pay_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_id"], name: "index_referrers_on_affiliate_id"
    t.index ["app_offer_id"], name: "index_referrers_on_app_offer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "social_email"
    t.string "social_name"
    t.string "mobile_number"
    t.string "source_ip"
    t.text "social_token"
    t.string "social_img_url"
    t.string "social_type"
    t.text "oauth_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "offer_events", "app_offers"
  add_foreign_key "referrers", "affiliates"
  add_foreign_key "referrers", "app_offers"
end
