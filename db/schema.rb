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

ActiveRecord::Schema[7.0].define(version: 2023_03_19_152303) do
  create_table "members", force: :cascade do |t|
    t.string "username"
    t.integer "subscriptions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_id"
  end

  create_table "subscription_plan", force: :cascade do |t|
    t.string "plan_id"
    t.string "name"
    t.string "currency"
    t.string "interval"
    t.string "product"
    t.integer "amount"
    t.string "description"
    t.integer "subscriptions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.string "interval"
    t.string "product"
    t.integer "amount"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "plan_id"
    t.integer "subscriptions"
    t.string "price_id"
    t.index ["subscriptions"], name: "index_subscription_plans_on_subscriptions"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "member_id"
    t.integer "subscription_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_subscriptions_on_member_id"
    t.index ["subscription_plan_id"], name: "index_subscriptions_on_subscription_plan_id"
  end

end
