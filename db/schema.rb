# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_21_011737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
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

  create_table "animals", force: :cascade do |t|
    t.string "scientific_name"
    t.string "common_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "encounters", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "animal_id", null: false
    t.string "time_of_day"
    t.string "weather_conditions"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "photos", default: [], array: true
    t.index ["animal_id"], name: "index_encounters_on_animal_id"
    t.index ["trip_id"], name: "index_encounters_on_trip_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "following_id"
    t.index ["follower_id", "following_id"], name: "index_friendships_on_follower_id_and_following_id", unique: true
    t.index ["following_id", "follower_id"], name: "index_friendships_on_following_id_and_follower_id", unique: true
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "destination"
    t.string "continent"
    t.datetime "travel_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "encounters", "animals"
  add_foreign_key "encounters", "trips"
  add_foreign_key "trips", "users"
end
