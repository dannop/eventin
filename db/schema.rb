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

ActiveRecord::Schema.define(version: 20171026205730) do

  create_table "archives", force: :cascade do |t|
    t.string "name"
    t.string "attachment"
    t.text "description"
    t.integer "lecture_id"
    t.integer "workshop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_archives_on_lecture_id"
    t.index ["workshop_id"], name: "index_archives_on_workshop_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkouts", force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "lot_id"
    t.integer "price"
    t.string "status"
    t.string "buyer_name"
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ejs", force: :cascade do |t|
    t.integer "members", default: 0
    t.string "name"
    t.string "college"
    t.string "icon"
    t.boolean "federated", default: false
    t.integer "federation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["federation_id"], name: "index_ejs_on_federation_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "begin_day"
    t.datetime "end_day"
    t.datetime "activity_begin_day"
    t.datetime "activity_end_day"
    t.datetime "room_begin_day"
    t.datetime "room_end_day"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "federations", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.string "icon"
    t.integer "members", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hot_events", force: :cascade do |t|
    t.integer "hotel_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_hot_events_on_event_id"
    t.index ["hotel_id"], name: "index_hot_events_on_hotel_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "photo"
    t.string "name"
    t.string "address"
    t.text "description"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_hotels_on_event_id"
  end

  create_table "lec_staffs", force: :cascade do |t|
    t.integer "staff_id"
    t.integer "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_lec_staffs_on_lecture_id"
    t.index ["staff_id"], name: "index_lec_staffs_on_staff_id"
  end

  create_table "lec_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_lec_users_on_lecture_id"
    t.index ["user_id"], name: "index_lec_users_on_user_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.datetime "the_day"
    t.integer "vacancies"
    t.text "description"
    t.integer "event_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["category_id"], name: "index_lectures_on_category_id"
    t.index ["event_id"], name: "index_lectures_on_event_id"
  end

  create_table "lots", force: :cascade do |t|
    t.datetime "close_date"
    t.datetime "open_date"
    t.boolean "purchasable"
    t.decimal "price"
    t.integer "ticket_current"
    t.integer "ticket_total"
    t.decimal "room_with"
    t.boolean "room_check"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_lots_on_event_id"
  end

  create_table "room_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_users_on_room_id"
    t.index ["user_id"], name: "index_room_users_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "hotel_id"
    t.string "photo"
    t.integer "bed_one"
    t.integer "bed_two"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "photo"
    t.string "name"
    t.integer "age"
    t.string "job"
    t.string "link_facebook"
    t.string "link_instagram"
    t.string "link_twitter"
    t.text "description"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_staffs_on_event_id"
  end

  create_table "transfer_asks", force: :cascade do |t|
    t.integer "asker_id"
    t.integer "replyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asker_id"], name: "index_transfer_asks_on_asker_id"
    t.index ["replyer_id"], name: "index_transfer_asks_on_replyer_id"
  end

  create_table "user_events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "cpf"
    t.string "job"
    t.date "birth"
    t.boolean "gender"
    t.boolean "payment_status"
    t.integer "ej_id"
    t.integer "room_id"
    t.string "photo"
    t.boolean "adm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.string "password_reset_token"
    t.index ["ej_id"], name: "index_users_on_ej_id"
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token"
    t.index ["room_id"], name: "index_users_on_room_id"
  end

  create_table "work_staffs", force: :cascade do |t|
    t.integer "staff_id"
    t.integer "workshop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staff_id"], name: "index_work_staffs_on_staff_id"
    t.index ["workshop_id"], name: "index_work_staffs_on_workshop_id"
  end

  create_table "work_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "workshop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_users_on_user_id"
    t.index ["workshop_id"], name: "index_work_users_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.datetime "the_day"
    t.integer "vacancies"
    t.text "description"
    t.integer "event_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["category_id"], name: "index_workshops_on_category_id"
    t.index ["event_id"], name: "index_workshops_on_event_id"
  end

end
