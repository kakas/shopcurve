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

ActiveRecord::Schema.define(version: 20161119115638) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "cart_items_count", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["shop_id"], name: "index_carts_on_shop_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "name",         default: ""
    t.integer  "phone"
    t.string   "address",      default: ""
    t.string   "email",        default: ""
    t.integer  "orders_count", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["phone"], name: "index_customers_on_phone"
    t.index ["shop_id"], name: "index_customers_on_shop_id"
  end

  create_table "order_infos", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "name",       default: ""
    t.integer  "phone"
    t.string   "address",    default: ""
    t.string   "email",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["order_id"], name: "index_order_infos_on_order_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "name"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "quantity"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "customer_id"
    t.decimal  "total_price",    precision: 8, scale: 2, default: "0.0"
    t.integer  "state_cd",                               default: 0
    t.boolean  "is_paid",                                default: false
    t.string   "payment_method",                         default: ""
    t.string   "token"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["shop_id"], name: "index_orders_on_shop_id"
    t.index ["token"], name: "index_orders_on_token", unique: true
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image",          default: ""
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["imageable_type", "imageable_id"], name: "index_photos_on_imageable_type_and_imageable_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       precision: 8, scale: 2
    t.integer  "stock",                               default: 0
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string   "title",      default: ""
    t.string   "email",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "shop_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["shop_id"], name: "index_users_on_shop_id"
  end

end
