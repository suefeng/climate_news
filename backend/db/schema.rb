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

ActiveRecord::Schema[7.1].define(version: 2024_08_02_010250) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "url"
    t.json "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_messages", force: :cascade do |t|
    t.json "message_body"
    t.boolean "is_chatbot"
    t.bigint "news_thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_thread_id"], name: "index_news_messages_on_news_thread_id"
  end

  create_table "news_threads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "run_id"
    t.string "thread_id"
    t.json "initial_query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
