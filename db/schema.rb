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

ActiveRecord::Schema[7.1].define(version: 2024_06_22_085715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arena_players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "arena_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_id"], name: "index_arena_players_on_arena_id"
    t.index ["user_id"], name: "index_arena_players_on_user_id"
  end

  create_table "arenas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.text "image_url"
    t.bigint "user_id", null: false
    t.integer "prize"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.bigint "category_id", null: false
    t.bigint "language_id", null: false
    t.integer "slots"
    t.index ["category_id"], name: "index_arenas_on_category_id"
    t.index ["language_id"], name: "index_arenas_on_language_id"
    t.index ["user_id"], name: "index_arenas_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.bigint "arena_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_id"], name: "index_chatrooms_on_arena_id"
  end

  create_table "commits", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_commits_on_project_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.text "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "arena_player_id", null: false
    t.text "repo_url"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_player_id"], name: "index_projects_on_arena_player_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score"
    t.integer "week_number"
    t.bigint "arena_player_id", null: false
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_player_id"], name: "index_tasks_on_arena_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pseudo"
    t.string "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "arena_players", "arenas"
  add_foreign_key "arena_players", "users"
  add_foreign_key "arenas", "categories"
  add_foreign_key "arenas", "languages"
  add_foreign_key "arenas", "users"
  add_foreign_key "chatrooms", "arenas"
  add_foreign_key "commits", "projects"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "projects", "arena_players"
  add_foreign_key "tasks", "arena_players"
end
